

class OrderDetailPost {
  String id;
  String storeTitle;
  String menuTitle;
  String menuPrice;
  String orderDate;
  String imgUrl;
  String userUid;
  String orderState;

  OrderDetailPost({
    required this.id,
    required this.storeTitle,
    required this.menuTitle,
    required this.menuPrice,
    required this.orderDate,
    required this.imgUrl,
    required this.userUid,
    required this.orderState,
  });

  factory OrderDetailPost.fromJson(Map<String, dynamic> json){
    return OrderDetailPost(
      id : json['id'] as String,
      storeTitle: json['storeTitle'] as String,
      menuTitle : json['menuTitle'] as String,
      menuPrice : json['menuPrice'] as String,
      orderDate : json['orderDate'] as String,
      imgUrl : json['imgUrl'] as String,
      userUid : json['userUid'] as String,
      orderState : json['orderState'] as String,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'storeTitle' : storeTitle,
      'menuTitle' : menuTitle,
      'menuPrice' : menuPrice,
      'orderDate' :  orderDate,
      'imgUrl' : imgUrl,
      'userUid' : userUid,
      'orderState' : orderState,
    };
  }

}
