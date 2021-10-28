import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/users_me.dart';
import '../../network/api_client.dart';
import '../../provider/account_provider.dart';
import '../login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountProvider provider = context.read<AccountProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('JWT Auth'),
        actions: <Widget>[
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: _dialog,
            ),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<UsersMe?>(
          future: ApiClient.getMe(
            provider.token ?? '',
          ),
          builder: (
            BuildContext context,
            AsyncSnapshot<UsersMe?> snapshot,
          ) {
            if (snapshot.hasData) {
              return _snapshotHasData(snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const CircularProgressIndicator.adaptive();
            }
          },
        ),
      ),
    );
  }

  Widget _dialog(BuildContext context) {
    return AlertDialog(
      content: const Text('Are you sure you want to log out?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => _logout(context),
          child: const Text('LOGOUT'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
      ],
    );
  }

  Future<void> _logout(BuildContext context) async {
    await context.read<AccountProvider>().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return const LoginPage();
      }),
      (Route<dynamic> route) => false,
    );
  }

  Widget _snapshotHasData(UsersMe data) {
    return ListView(
      children: <Widget>[
        ListTile(
          subtitle: Text('${data.id ?? ''}'),
          title: const Text('ID'),
        ),
        ListTile(
          subtitle: Text(data.name ?? ''),
          title: const Text('Name'),
        ),
        ListTile(
          subtitle: Text(data.link ?? ''),
          title: const Text('Link'),
        ),
        ListTile(
          subtitle: Text(data.slug ?? ''),
          title: const Text('Slug'),
        ),
      ],
    );
  }
}
