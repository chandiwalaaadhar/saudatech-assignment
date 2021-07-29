import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudatechproject/providers/CharacterProvider.dart';
import 'package:saudatechproject/providers/NavBarProvider.dart';
import 'package:saudatechproject/widgets/AppNavigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: BottomNavBarProvider(),
          ),
          ChangeNotifierProvider.value(
            value: CharacterProvider(),
          ),
        ],
        child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'Lato',
              textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headline3: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
                bodyText1: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                bodyText2: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue),
              ),
            ),
            home: AppNavigator(),
            routes: {
              AppNavigator.routeName: (context) => AppNavigator(),
            }));
  }
}
