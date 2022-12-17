class UpdateAddressModel {
  bool? status;
  Data? data;

  UpdateAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;
  int? id;


  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    notes = json['notes'];
    id = json['id'];
  }
}
