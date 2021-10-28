import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/auth_token.dart';
import '../../provider/account_provider.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _onSend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          _field(
            controller: _controllerUsername,
            label: 'Username/Email',
            suffixIcon: const Icon(Icons.email),
            keyboardType: TextInputType.emailAddress,
            enable: !_onSend,
          ),
          _field(
            controller: _controllerPassword,
            label: 'Password',
            suffixIcon: const Icon(Icons.password),
            keyboardType: TextInputType.visiblePassword,
            obsecureText: true,
            enable: !_onSend,
          ),
        ],
      ),
      floatingActionButton: _onSend
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.send),
              onPressed: _login,
            ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    String? hint,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    bool obsecureText = false,
    bool enable = true,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        obscureText: obsecureText,
        enabled: enable,
      ),
    );
  }

  Future<void> _login() async {
    setState(() => _onSend = true);
    AccountProvider provider = context.read<AccountProvider>();
    AuthToken auth = await provider.login(
      username: _controllerUsername.text,
      password: _controllerPassword.text,
    );
    if (auth.token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            auth.message ?? 'Oops! Something went wrong...',
          ),
        ),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return const HomePage();
          },
        ),
        (Route<dynamic> route) => false,
      );
    }
    setState(() => _onSend = false);
  }
}
