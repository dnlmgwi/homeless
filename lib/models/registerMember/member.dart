class Member {
  //TODO: Personal
  String homeless_name = '';
  String surname = '';
  String age = '';
  String race = '';
  String gender = '';
  String dob;

  //TODO: Contact Details
  String alternative_phoneNumber = '';
  String primary_phoneNumber = '';

  //TODO: Additional
  String services_needed = '';
  DateTime approximateDateStartedHomeless;
  String livingSituation = '';
  String skillLevel = '';
  String language = '';
  String residentialMoveInDate = '';

  //TODO: Location Search Address and Find Co-ordinates.
  String address = '';
  double lat;
  double lng;
  String streetNickname = '';

  bool consent = false;

  //TODO: Health Care Services
  List<String> comorbidities = [];
  // var ssn = '';
  // var health_Status = '';
  // var disabilityCondition = '';
}
