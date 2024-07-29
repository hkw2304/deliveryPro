class StorePost {
  String id;
  String storeTitle;
  String menuTitle1;
  String menuTitle2;
  String menuTitle3;
  String menuPrice1;
  String menuPrice2;
  String menuPrice3;
  String imgUrl1;
  String imgUrl2;
  String imgUrl3;
  String deliveryTime;
  String leastMoney;

  StorePost({
    required this.id,
    required this.storeTitle,
    required this.menuTitle1,
    required this.menuTitle2,
    required this.menuTitle3,
    required this.menuPrice1,
    required this.menuPrice2,
    required this.menuPrice3,
    required this.imgUrl1,
    required this.imgUrl2,
    required this.imgUrl3,
    required this.deliveryTime,
    required this.leastMoney,
  });

  factory StorePost.fromJson(Map<String, dynamic> json) {
    return StorePost(
      id : json['id'] as String,
      storeTitle : json['storeTitle'] as String,
      menuTitle1 : json['menuTitle1'] as String,
      menuTitle2 : json['menuTitle2'] as String,
      menuTitle3 : json['menuTitle3'] as String,
      menuPrice1 :json['menuPrice1'] as String,
      menuPrice2 :json['menuPrice2'] as String,
      menuPrice3 :json['menuPrice3'] as String,
      imgUrl1 : json['imgUrl1'] as String,
      imgUrl2 : json['imgUrl2'] as String,
      imgUrl3 : json['imgUrl3'] as String,
      deliveryTime : json['deliveryTime'] as String,
      leastMoney : json['leastMoney'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'storeTitle': storeTitle,
      'menuTitle1': menuTitle1,
      'menuTitle2': menuTitle2,
      'menuTitle3': menuTitle3,
      'menuPrice1': menuPrice1,
      'menuPrice2': menuPrice2,
      'menuPrice3': menuPrice3,
      'imgUrl1': imgUrl1,
      'imgUrl2': imgUrl2,
      'imgUrl3': imgUrl3,
      'deliveryTime': deliveryTime,
      'leastMoney': leastMoney,
    };
  }
}
