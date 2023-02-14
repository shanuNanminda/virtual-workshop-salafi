class WorkShop {
  WorkShop({
    required this.id,
    required this.workshopName,
    required this.address,
    required this.location,
    required this.phoneNumber,
  });
  late final int id;
  late final String workshopName;
  late final String address;
  late final String location;
  late final String phoneNumber;
  double distance=0.0;
  
  WorkShop.fromJson(Map<String, dynamic> json){
    id = json['id'];
    workshopName = json['workshop_name'];
    address = json['address'];
    location = json['location'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['workshop_name'] = workshopName;
    _data['address'] = address;
    _data['location'] = location;
    _data['phone_number'] = phoneNumber;
    return _data;
  }
}