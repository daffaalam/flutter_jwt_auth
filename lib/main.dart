import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/provider/account_provider.dart';
import 'src/ui/splash/splash_page.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AccountProvider();
      },
      child: const MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
