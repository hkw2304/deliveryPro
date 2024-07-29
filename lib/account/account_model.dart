
import 'package:firebase_auth/firebase_auth.dart';

class AccountModel{
  void logout() async {
    print('로그아웃!!');
    await FirebaseAuth.instance.signOut();
  }
}