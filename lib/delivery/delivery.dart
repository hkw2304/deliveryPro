import 'package:deliveryproject/create/create_post.dart';
import 'package:deliveryproject/store/chicken.dart';
import 'package:deliveryproject/store/china.dart';
import 'package:deliveryproject/store/don.dart';
import 'package:deliveryproject/store/fastfood.dart';
import 'package:deliveryproject/store/japan.dart';
import 'package:deliveryproject/store/pizza.dart';
import 'package:deliveryproject/store/western.dart';
import 'package:deliveryproject/widgets/banner.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  Widget build(BuildContext context) {
    List<String> tabMenu = [
      '치킨',
      '피자',
      '돈까스',
      '일식',
      '중식',
      '양식',
      '패스트푸드',
    ];
    // DefaultTabController는 TabBar와 TabBarView를 연결하는 역할
    return DefaultTabController(
      length: tabMenu.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('배달'),
          bottom: TabBar(
            tabs: List.generate(
              tabMenu.length,
                  (index) =>
                  Tab(
                    text: tabMenu[index],
                  ),
            ),
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.black38,
            tabAlignment: TabAlignment.start,

          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Create_post()));
          },
          backgroundColor: Colors.blue[100],
          child: Icon(Icons.add),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: ChickenFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: PizzaFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: PorkFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: JapenFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: ChinaFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: WesternFood()),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                BannerWidget(),
                Expanded(child: FastFood()),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


