import 'package:carousel_slider/carousel_slider.dart';
import 'package:deliveryproject/domain/storePost.dart';
import 'package:deliveryproject/order_details/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class menuDetail extends StatelessWidget {
  final StorePost item;
  final orderModel = OrderRegister();

  menuDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final String userUid = FirebaseAuth.instance.currentUser!.uid;
    List<String> bannerList = [
      item.imgUrl1,
      item.imgUrl2,
      item.imgUrl3,
    ];

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(
              itemCount: bannerList.length,
              itemBuilder: (context, itemIndex, realIndex) {
                return Image.network(
                  bannerList[itemIndex],
                );
              },
              options: CarouselOptions(
                aspectRatio: 0.48 / 0.3,
                viewportFraction: 1.0,
                autoPlay: true,
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  height: 40.0,
                  child: Container(
                    color: Color(0xffCCFFFF),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            '혜택 무료체험 중',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15.0,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    item.storeTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 29.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amberAccent),
                      Text(
                        '4.9',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '리뷰 439개',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          size: 16.0, color: Colors.black38),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '최소주문금액',
                        style: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(
                        '${item.leastMoney}원',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '배달시간',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        size: 15.0,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        item.deliveryTime,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 83.0,
                      ),
                      Icon(
                        Icons.add_circle,
                        size: 18.0,
                        color: Colors.cyan,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '배달팁 무료',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
              child: Container(
                color: Colors.black12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                '추천 메뉴',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              item.menuTitle1,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            content: Text(
                              '${item.menuPrice1}원 입니다.',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancle');
                                },
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  orderModel.uploadOrder(
                                      item.storeTitle, item.menuTitle1, item.menuPrice1, item.imgUrl1, userUid);
                                  Navigator.pop(context, 'Ok');
                                },
                                child: Text('주문하기'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.menuTitle1,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '부위/토핑 선택 가능',
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${item.menuPrice1}원',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                            Image.network(
                              item.imgUrl1,
                              width: 130.0,
                              height: 130.0,
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              item.menuTitle2,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            content: Text(
                              '${item.menuPrice2}원 입니다.',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancle');
                                },
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  orderModel.uploadOrder(
                                      item.storeTitle, item.menuTitle2, item.menuPrice2, item.imgUrl2, userUid);
                                  Navigator.pop(context, 'Ok');
                                },
                                child: Text('주문하기'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.menuTitle2,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '부위/토핑 선택 가능',
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${item.menuPrice2}원',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                            Image.network(
                              item.imgUrl2,
                              width: 130.0,
                              height: 130.0,
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              item.menuTitle3,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            content: Text(
                              '${item.menuPrice3}원 입니다.',
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, 'Cancle');
                                },
                                child: Text('취소'),
                              ),
                              TextButton(
                                onPressed: () {
                                  orderModel.uploadOrder(
                                      item.storeTitle, item.menuTitle3, item.menuPrice3, item.imgUrl3, userUid);
                                  Navigator.pop(context, 'Ok');
                                },
                                child: Text('주문하기'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.menuTitle3,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '부위/토핑 선택 가능',
                                  style: TextStyle(
                                    color: Colors.black38,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${item.menuPrice3}원',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                            Image.network(
                              item.imgUrl3,
                              width: 130.0,
                              height: 130.0,
                            ),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
