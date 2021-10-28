import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/account_provider.dart';
import '../home/home_page.dart';
import '../login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> _initData() async {
    AccountProvider provider = context.read<AccountProvider>();
    await provider.init();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return provider.token == null ? const LoginPage() : const HomePage();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
