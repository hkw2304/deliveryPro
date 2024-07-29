import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/domain/charge.dart';

class Charge {

  getChargeMoneyInfo(String userUid) async {
    final result = await FirebaseFirestore.instance.collection('chargePosts').doc(userUid).get();
    return result.data();
  }

  final Stream<QuerySnapshot<ChargePost>> chargePostsStream = FirebaseFirestore
      .instance
      .collection('chargePosts')
      .withConverter<ChargePost>(
        fromFirestore: (snapshot, _) => ChargePost.fromJson(snapshot.data()!),
        toFirestore: (ChargePost, _) => ChargePost.toJson(),
      )
      .snapshots();

  Future<void> createCharge(String userUid, String money) async {
    int userMoney = 0;
    final chargetRef = FirebaseFirestore.instance
        .collection('chargePosts')
        .withConverter<ChargePost>(
          fromFirestore: (snapshot, _) => ChargePost.fromJson(snapshot.data()!),
          toFirestore: (ChargePost, _) => ChargePost.toJson(),
        );
    final newChargetRef = chargetRef.doc(userUid);

    final result = await FirebaseFirestore.instance.collection('chargePosts').doc(userUid).get();

    userMoney = int.parse(money);

    if(!(result.data()?.isNotEmpty == null)){
      userMoney += int.parse((result.data() as Map)['money']);
    }

    newChargetRef.set(
      ChargePost(id: newChargetRef.id, userUid: userUid, money: '$userMoney'),
    );

  }
}
