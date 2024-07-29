class ChargePost{
  String id;
  String userUid;
  String money;

  ChargePost({
    required this.id,
    required this.userUid,
    required this.money,

  });

  factory ChargePost.fromJson(Map<String, dynamic> json){
    return ChargePost(
      id : json['id'] as String,
      userUid : json['userUid'] as String,
      money : json['money'] as String,
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'userId' : userUid,
      'money' : money,
    };
  }

}