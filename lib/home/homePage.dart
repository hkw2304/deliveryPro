import 'package:deliveryproject/account/account_model.dart';
import 'package:deliveryproject/delivery/delivery.dart';
import 'package:deliveryproject/home/home_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget build(BuildContext context) {
    final model = AccountModel();
    final userModel = HomeModel();
    List<DeliveryMenu> deliveryMenu = [
      DeliveryMenu(
        title: '주문하기',
        imageUrl: 'images/deliveryMenuIcon/logo.jpg',
      ),

    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        titleSpacing: 20.0,
        backgroundColor: Colors.white38,
        title: Text('${userModel.getNickName()} 님'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.view_headline,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
            ),
          ),
          IconButton(
            onPressed: () {
              model.logout();
            },
            icon: Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80.0,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: deliveryMenu.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeliveryPage(),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            '${deliveryMenu[index].imageUrl}',
                        
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${deliveryMenu[index].title}',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

class DeliveryMenu {
  final String title;
  final String imageUrl;

  DeliveryMenu({
    required this.imageUrl,
    required this.title,
  });
}
