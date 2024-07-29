import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deliveryproject/charge/charge_model.dart';
import 'package:deliveryproject/domain/charge.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChargePage extends StatefulWidget {
  const ChargePage({super.key});

  @override
  State<ChargePage> createState() => _ChargePageState();
}

class _ChargePageState extends State<ChargePage> {
  final _chargeMoneyCtr = TextEditingController();
  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chargeMoneyCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Charge();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 85,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
        title: Text(
          '충전하기',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 310.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff00f5a0), Color(0xff00d9f5)],
                  stops: [0, 1],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '페이머니 충전',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0,
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: 65.0,
                                  height: 35.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                        color: Colors.black12, width: 1),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '주문상세',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Icon(
                          Icons.list,
                          size: 35.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      '페이머니로 결제하면',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      '결제금액의 0.5%가 포인트로 적립돼요!!',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    FutureBuilder(
                      future: model.getChargeMoneyInfo(userUid),
                      builder: (context, snapshot) {

                        return snapshot.hasData
                            ? Text(
                                '${ (snapshot.data as Map)['money']} 원',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              )
                            : Text(
                                '0 원',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                ),
                              );
                      },

                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Center(
                      child: Container(
                        width: 150.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.cyan),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext build) {
                                return AlertDialog(
                                  title: Text('충전'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '금액 입력',
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      TextField(
                                        controller: _chargeMoneyCtr,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        decoration: new InputDecoration(
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.teal)),
                                          labelText: '금액',
                                          prefixIcon: const Icon(
                                            Icons.arrow_right_outlined,
                                            size: 30.0,
                                            color: Colors.green,
                                          ),
                                          prefixText: ' ',
                                          suffixText: '입력',
                                          suffixStyle: const TextStyle(
                                              color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        model.createCharge(
                                            userUid, _chargeMoneyCtr.text);
                                        Navigator.pop(context, 'Ok');
                                        setState(() {

                                        });
                                      },
                                      child: Text('충전하기'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text(
                            '충전',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
