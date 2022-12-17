class AddressModel {
  bool? status;

  AddressPage? data;

  AddressModel({this.status,  this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  AddressPage.fromJson(json['data']) : null;
  }


}

class AddressPage {
  int? currentPage;
  List<AddressData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  AddressPage(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total,
      });

  AddressPage.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add( AddressData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class  AddressData {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  double? latitude;
  double? longitude;

  AddressData(
      {this.id,
        this.name,
        this.city,
        this.region,
        this.details,
        this.notes,
        this.latitude,
        this.longitude});

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }


}
