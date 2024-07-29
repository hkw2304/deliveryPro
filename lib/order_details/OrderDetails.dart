import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/domain/orderDetailsPost.dart';
import 'package:deliveryproject/order_details/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    final model = OrderRegister();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 85,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        title: Text(
          '주문내역',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.home,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.view_headline,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<OrderDetailPost>>(
        stream: model.orderPostsStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error!!');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<OrderDetailPost> posts =
              snapshot.data!.docs.map((e) => e.data()).toList();
          List<OrderDetailPost> afterposts =
              posts.where((item) => item.userUid == userUid).toList();
          if (afterposts.isEmpty) {
            return Center(
              child: Text('주문내역이 없당깨렁~~'),
            );
          }
          return GridView.builder(
            itemCount: afterposts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '주문 날짜 : ${afterposts[index].orderDate}',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Stack(
                            children: [
                              Container(
                                width: 65.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border:
                                      Border.all(color: Colors.black38, width: 1),
                                ),
                                child: Center(
                                  child: Text('주문상세'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  afterposts[index].menuTitle,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                  ),
                                ),
                                content: Text(
                                  afterposts[index].orderState == '결제요청'
                                      ? '결제 하시겠습니까? / 취소 하시겠습니까?'
                                      : '취소 하시겠습니까?',
                                ),
                                actions: <Widget>[
                                  if (afterposts[index].orderState == '결제요청')
                                    TextButton(
                                      onPressed: () {
                                        model.payment(
                                            userUid,
                                            afterposts[index].menuPrice,
                                            afterposts[index].id);
                                        //
                                        // Future.delayed(Duration(seconds: 5), () {
                                        //   model.deleteOrderPost(
                                        //       afterposts[index].id);
                                        // });

                                        Navigator.pop(context, 'Ok');
                                        setState(() {});
                                      },
                                      child: Text(
                                        '결제하기',
                                      ),
                                    ),
                                  TextButton(
                                    onPressed: () {
                                      model.deleteOrderPost(afterposts[index].id);
                                      Navigator.pop(context, 'Cancle');
                                    },
                                    child: Text('취소하기'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 110.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child:
                                        Image.network(afterposts[index].imgUrl),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Container(
                                  height: 110.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            afterposts[index].storeTitle,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.0,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 15.0,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '${afterposts[index].menuTitle} ',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        '${afterposts[index].menuPrice}원',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              afterposts[index].orderState,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
