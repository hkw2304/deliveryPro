import 'dart:convert';

import 'package:deliveryproject/domain/store_api.dart';
import 'package:deliveryproject/key/key.dart';
import 'package:http/http.dart' as http;

Future<List<StoreApi>> fetchStore() async {

  late List<StoreApi> storeList;
  String url = 'http://openapi.seoul.go.kr:8088/${apiKey}/json/LOCALDATA_072404/1/4/';

  final res = await http.get(Uri.parse(url));
  final resBody = res.body;
  print('오류1');
  final jsonMap = json.decode(resBody);

print('오류2');
  storeList = jsonMap.containsKey('LOCALDATA_072404')
    ? (jsonMap['LOCALDATA_072404']['row'] as List)
      .map((e) => StoreApi.fromJson(e))
      .toList()
    : List.empty();
  print('storeList >> ${storeList}');
  if(res.statusCode == 200){
    print('여까지 왔냐');
    return storeList;
  }
  else{
    print('에러나나???');
    throw Exception('Failed to load park info');
  }
}



