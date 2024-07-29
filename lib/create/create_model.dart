import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/domain/storePost.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateModel {
  Future<void> uploadPost(
      List<File> images,
      String menu,
      String storeTitle,
      String menuTitle1,
      String menuTitle2,
      String menuTitle3,
      String menuPrice1,
      String menuPrice2,
      String menuPrice3,
      String deliveryTime,
      String leastMoney) async {
    final storageRef1 = FirebaseStorage.instance.ref();
    final storageRef2 = FirebaseStorage.instance.ref();
    final storageRef3 = FirebaseStorage.instance.ref();

    // 등록 시간을 기본키값으로 설정해서 동시에 올리면 사진이 1개만 들어간다. 장마다 드르게 값을 줘야해서 설정해줌
    final imageRef1 = storageRef1
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}_1.png');
    final imageRef2 = storageRef2
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}_2.png');
    final imageRef3 = storageRef3
        .child('postImages/${DateTime.now().millisecondsSinceEpoch}_3.png');
    await imageRef1.putFile(images[0]);
    await imageRef2.putFile(images[1]);
    await imageRef3.putFile(images[2]);

    final downloadUrl1 = await imageRef1.getDownloadURL();
    final downloadUrl2 = await imageRef2.getDownloadURL();
    final downloadUrl3 = await imageRef3.getDownloadURL();

    if (menu == '치킨') {
      final postsRef = FirebaseFirestore.instance
          .collection('posts')
          .withConverter<StorePost>(
            fromFirestore: (snapshot, _) =>
                StorePost.fromJson(snapshot.data()!),
            toFirestore: (StorePost, _) => StorePost.toJson(),
          );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '피자'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsPizza')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '돈까스'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsPork')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '일식'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsJapen')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '중식'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsChina')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '양식'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsWestern')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else if(menu == '패스트푸드'){
      final postsRef = FirebaseFirestore.instance
          .collection('postsFest')
          .withConverter<StorePost>(
        fromFirestore: (snapshot, _) =>
            StorePost.fromJson(snapshot.data()!),
        toFirestore: (StorePost, _) => StorePost.toJson(),
      );
      final newPostRef = postsRef.doc();

      newPostRef.set(
        StorePost(
          id: newPostRef.id,
          storeTitle: storeTitle,
          menuTitle1: menuTitle1,
          menuTitle2: menuTitle2,
          menuTitle3: menuTitle3,
          menuPrice1: menuPrice1,
          menuPrice2: menuPrice2,
          menuPrice3: menuPrice3,
          imgUrl1: downloadUrl1,
          imgUrl2: downloadUrl2,
          imgUrl3: downloadUrl3,
          deliveryTime: deliveryTime,
          leastMoney: leastMoney,
        ),
      );
    }
    else{
      print('메뉴를 다시 입력!!!');
    }
  }
}
