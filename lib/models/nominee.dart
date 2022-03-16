/// plan_name : "GHANA SHINNING STARS AWARDS  22"
/// nominee_desc : null
/// nominee : " ALITO NATION"
/// nom_pic : null
/// nom_id : "AUaaUQ5ZNxJtdGxRIdfL4A%3D%3D"
/// nom_code : "JI7"
/// category_id : "tMdOr%2Bwp3NupgNeDoehjfA%3D%3D"
/// category : "ARTISTE OF THE YEAR"

class Nominee {
  Nominee({
      String? planName, 
      String? nomineeDesc,
      String? nominee, 
      String? nomPic,
      String? nomId, 
      String? nomCode, 
      String? categoryId, 
      String? category,}){
    _planName = planName;
    _nomineeDesc = nomineeDesc;
    _nominee = nominee;
    _nomPic = nomPic;
    _nomId = nomId;
    _nomCode = nomCode;
    _categoryId = categoryId;
    _category = category;
}

  Nominee.fromJson(dynamic json) {
    _planName = json['plan_name'];
    _nomineeDesc = json['nominee_desc'];
    _nominee = json['nominee'];
    _nomPic = json['nom_pic'];
    _nomId = json['nom_id'];
    _nomCode = json['nom_code'];
    _categoryId = json['category_id'];
    _category = json['category'];
  }
  String? _planName;
  dynamic _nomineeDesc;
  String? _nominee;
  dynamic _nomPic;
  String? _nomId;
  String? _nomCode;
  String? _categoryId;
  String? _category;

  String? get planName => _planName;
  dynamic get nomineeDesc => _nomineeDesc;
  String? get nominee => _nominee;
  dynamic get nomPic => _nomPic;
  String? get nomId => _nomId;
  String? get nomCode => _nomCode;
  String? get categoryId => _categoryId;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['plan_name'] = _planName;
    map['nominee_desc'] = _nomineeDesc;
    map['nominee'] = _nominee;
    map['nom_pic'] = _nomPic;
    map['nom_id'] = _nomId;
    map['nom_code'] = _nomCode;
    map['category_id'] = _categoryId;
    map['category'] = _category;
    return map;
  }

}