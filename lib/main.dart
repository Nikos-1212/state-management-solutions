import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_management/views/tabbar/home.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,      
    //   routeInformationParser:MyApproutes.returnRouter(true).routeInformationParser,
    //   routerDelegate: MyApproutes.returnRouter(true).routerDelegate,
    // );
  }
}
