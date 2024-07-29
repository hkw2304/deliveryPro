class StoreApi {
  final String BPLCNM;
  final String UPTAENM;
  final String X;
  final String Y;

  StoreApi(
      {required this.BPLCNM,
      required this.UPTAENM,
      required this.X,
      required this.Y,
      }
    );

  factory StoreApi.fromJson(Map<String, dynamic> json){
    return StoreApi(
        BPLCNM : json['BPLCNM'] as String,
        UPTAENM : json['UPTAENM'] as String,
        X : json['X'] as String,
        Y : json['Y'] as String
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'BPLCNM': BPLCNM,
      'UPTAENM': UPTAENM,
      'X': X,
      'Y': Y
    };
  }

}
