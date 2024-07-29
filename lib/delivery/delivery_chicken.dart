import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/domain/storePost.dart';

class DeliveryChicken {
  final Stream<QuerySnapshot<StorePost>> postsStream = FirebaseFirestore.instance
      .collection('posts')
      .withConverter<StorePost>(
        fromFirestore: (snapshot, _) => StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      )
      .snapshots();
}