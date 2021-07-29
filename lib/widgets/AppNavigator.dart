import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saudatechproject/providers/NavBarProvider.dart';
import 'package:saudatechproject/screens/AlgorithmScreen.dart';
import 'package:saudatechproject/screens/CharacterScreen.dart';

class AppNavigator extends StatefulWidget {
  static const routeName = '/appnav';

  @override
  _AppNavigatorState createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  List<Widget> _pages = [
    AlgorithmScreen(),
    CharacterScreen()
  ]; //PurchaseScreen(),];

  @override
  Widget build(BuildContext context) {
    var navBarProvider = Provider.of<BottomNavBarProvider>(context);
    var currentPage = Provider.of<BottomNavBarProvider>(context).page;

    // ignore: missing_return
    Widget getBody() {
      if (currentPage == 0)
        return AlgorithmScreen();
      else if (currentPage == 1) return CharacterScreen();
      //else if (currentPage == 2) //return ProfileScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SaudaTech'),
        backgroundColor: Color.fromRGBO(43, 85, 87, 1),
      ),
      body: IndexedStack(
        children: _pages,
        index: currentPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: 'Algorithm',
            backgroundColor: Color.fromRGBO(43, 85, 87, 1),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
            backgroundColor: Color.fromRGBO(191, 159, 69, 1),
          ),
        ],
        currentIndex: navBarProvider.page,
        onTap: (_selectedIndex) {
          navBarProvider.setPage(_selectedIndex);
        },
        elevation: 30,
      ),
    );
  }
}
