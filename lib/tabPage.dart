import 'package:deliveryproject/charge/charge.dart';
import 'package:deliveryproject/home/homePage.dart';
import 'package:deliveryproject/order_details/OrderDetails.dart';
import 'package:deliveryproject/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

class TabPage extends StatefulWidget {
  TabPage({
    super.key,
  });

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _currentIndex = 0;
  final _pages = [
    HomePage(),
    SearchPage(),
    ChargePage(),
    OrderDetailsPage(),
    ProfileScreen(
      providerConfigs: [
        EmailProviderConfiguration(),
      ],
      avatarSize: 24,
    ),
  ];

  _TabPageState();

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        unselectedItemColor: Colors.black38,
        selectedItemColor: Colors.blue,
        selectedLabelStyle: TextStyle(color: Colors.blue),
        // isScrollable: true,
        // labelColor: Colors.black,
        // unselectedLabelColor: ,
        // tabAlignment: TabAlignment.start,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: '지도',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            label: '충전하기',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list_alt,
            ),
            label: '주문내역',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_reaction,
            ),
            label: '내정보',
          ),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
