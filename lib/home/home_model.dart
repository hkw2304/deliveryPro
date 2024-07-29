import 'package:firebase_auth/firebase_auth.dart';

class HomeModel{
  String getNickName(){
    return FirebaseAuth.instance.currentUser?.displayName ?? '이름을 설정하세요.';
  }
}