import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/domain/charge.dart';
import 'package:deliveryproject/domain/orderDetailsPost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderRegister {
  final Stream<QuerySnapshot<OrderDetailPost>> orderPostsStream =
      FirebaseFirestore.instance
          .collection('orderPosts')
          .withConverter<OrderDetailPost>(
            fromFirestore: (snapshot, _) =>
                OrderDetailPost.fromJson(snapshot.data()!),
            toFirestore: (OrderDetailPost, _) => OrderDetailPost.toJson(),
          )
          .snapshots();

  Future<void> uploadOrder(String storeTitle, String menuTitle,
      String menuPrice, String imgUrl, String userUid) async {
    final postsRef = FirebaseFirestore.instance
        .collection('orderPosts')
        .withConverter<OrderDetailPost>(
          fromFirestore: (snapshot, _) =>
              OrderDetailPost.fromJson(snapshot.data()!),
          toFirestore: (OrderDetailPost, _) => OrderDetailPost.toJson(),
        );
    final newPostRef = postsRef.doc();
    final String orderDate = DateFormat("yyyy년 MM월 dd일").format(DateTime.now());

    print('여기 오냐 >>> ${orderDate}');
    newPostRef.set(
      OrderDetailPost(
        id: newPostRef.id,
        storeTitle: storeTitle,
        menuTitle: menuTitle,
        menuPrice: menuPrice,
        orderDate: orderDate,
        imgUrl: imgUrl,
        userUid: userUid,
        orderState: '결제요청',
      ),
    );
  }

  void deleteOrderPost(String docID) async {
    final documentReference =
        FirebaseFirestore.instance.collection('orderPosts').doc(docID);
    await documentReference
        .delete()
        .whenComplete(
          () => print('삭제성공'),
        )
        .onError(
          (error, stackTrace) => print(error.toString()),
        );
  }

  Future<bool> payment(String userUid, String money, String id) async {
    int userMoney = 0;
    int chargeMoney = 0;
    final chargetRef = FirebaseFirestore.instance
        .collection('chargePosts')
        .withConverter<ChargePost>(
          fromFirestore: (snapshot, _) => ChargePost.fromJson(snapshot.data()!),
          toFirestore: (ChargePost, _) => ChargePost.toJson(),
        );
    final newChargetRef = chargetRef.doc(userUid);

    final result = await FirebaseFirestore.instance
        .collection('chargePosts')
        .doc(userUid)
        .get();

    userMoney = int.parse(money);

    if (!(result.data()?.isNotEmpty == null)) {
      chargeMoney = int.parse((result.data() as Map)['money']);
      if (chargeMoney < userMoney) {
        print('잔액부족');
        return false;
      }
      chargeMoney -= userMoney;
    }

    newChargetRef.set(
      ChargePost(id: newChargetRef.id, userUid: userUid, money: '$chargeMoney'),
    );

    final updateDocReference =
        FirebaseFirestore.instance.collection('orderPosts').doc(id);
    print('>>>>> $updateDocReference');
    await updateDocReference.update({
      'orderState': '결제완료',
    });

    Future.delayed(Duration(seconds: 5), () {
      deleteOrderPost(id);
    });

    return true;
  }
}
