/// logo : "uploads/categories/"
/// category_desc : ""
/// category : "ARTISTE OF THE YEAR"
/// cat_id : "000001416"

class Category {
  Category({
      String? logo, 
      String? categoryDesc, 
      String? category, 
      String? catId,}){
    _logo = logo;
    _categoryDesc = categoryDesc;
    _category = category;
    _catId = catId;
}

  Category.fromJson(dynamic json) {
    _logo = json['logo'];
    _categoryDesc = json['category_desc'];
    _category = json['category'];
    _catId = json['cat_id'];
  }
  String? _logo;
  String? _categoryDesc;
  String? _category;
  String? _catId;

  String? get logo => _logo;
  String? get categoryDesc => _categoryDesc;
  String? get category => _category;
  String? get catId => _catId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['logo'] = _logo;
    map['category_desc'] = _categoryDesc;
    map['category'] = _category;
    map['cat_id'] = _catId;
    return map;
  }

}