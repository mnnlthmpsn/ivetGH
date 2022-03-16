/// unit_cost : "1"
/// show_result : true
/// plan_id : "000079"
/// plan_desc : "GHANA SHINNING STARS AWARDS  22"
/// logo : null
/// entity_name : "Talentshouse Entertainment"
/// entity_id : "IfD5wg1MLLt6mPRgulFXng%3D%3D"
/// award : "GHANA SHINNING STARS AWARDS  22"

class Event {
  Event({
      String? unitCost, 
      bool? showResult, 
      String? planId, 
      String? planDesc, 
      dynamic logo, 
      String? entityName, 
      String? entityId, 
      String? award,}){
    _unitCost = unitCost;
    _showResult = showResult;
    _planId = planId;
    _planDesc = planDesc;
    _logo = logo;
    _entityName = entityName;
    _entityId = entityId;
    _award = award;
}

  Event.fromJson(dynamic json) {
    _unitCost = json['unit_cost'];
    _showResult = json['show_result'];
    _planId = json['plan_id'];
    _planDesc = json['plan_desc'];
    _logo = json['logo'];
    _entityName = json['entity_name'];
    _entityId = json['entity_id'];
    _award = json['award'];
  }
  String? _unitCost;
  bool? _showResult;
  String? _planId;
  String? _planDesc;
  dynamic _logo;
  String? _entityName;
  String? _entityId;
  String? _award;

  String? get unitCost => _unitCost;
  bool? get showResult => _showResult;
  String? get planId => _planId;
  String? get planDesc => _planDesc;
  dynamic get logo => _logo;
  String? get entityName => _entityName;
  String? get entityId => _entityId;
  String? get award => _award;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit_cost'] = _unitCost;
    map['show_result'] = _showResult;
    map['plan_id'] = _planId;
    map['plan_desc'] = _planDesc;
    map['logo'] = _logo;
    map['entity_name'] = _entityName;
    map['entity_id'] = _entityId;
    map['award'] = _award;
    return map;
  }

}