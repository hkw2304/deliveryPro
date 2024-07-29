import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/delivery/delivery_japen.dart';
import 'package:deliveryproject/domain/storePost.dart';
import 'package:deliveryproject/store_detail/menuDetail.dart';
import 'package:flutter/material.dart';

class JapenFood extends StatelessWidget {
  const JapenFood({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = DeliveryJapenModel();

    return StreamBuilder<QuerySnapshot<StorePost>>(
        stream: model.postsStream,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text('Error!!!');
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          List<StorePost> posts = snapshot.data!.docs.map((e) => e.data()).toList();
          return GridView.builder(
            itemCount: posts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => menuDetail(
                          item: posts[index],
                        )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SizedBox(
                                      width: 150.0,
                                      height: 150.0,
                                      child: Image.network(
                                        posts[index].imgUrl1,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          posts[index].menuTitle1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${posts[index].menuPrice1}원',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SizedBox(
                                      width: 150.0,
                                      height: 150.0,
                                      child: Image.network(
                                        posts[index].imgUrl2,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          posts[index].menuTitle2,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${posts[index].menuPrice2}원',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: SizedBox(
                                      width: 150.0,
                                      height: 150.0,
                                      child: Image.network(
                                        posts[index].imgUrl3,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          posts[index].menuTitle3,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          '${posts[index].menuPrice3}원',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text(
                            posts[index].storeTitle,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 18,
                          ),
                          Text(
                            '4.9',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.shopping_cart, size: 16, color: Colors.blue),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            posts[index].deliveryTime,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Text(
                              '배달팁 ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text('무료'),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.add_circle,
                            size: 16.0,
                            color: Colors.cyan,
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Text(
                              '최소주문',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            '${posts[index].leastMoney}원',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}

