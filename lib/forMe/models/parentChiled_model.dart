class ChildInfo {
  String name;
  String phone;
  String id;
  String schoolAdd;
  String homeAdd;
  String schoolLat;
  String schoolLon;
  String homeLat;
  String homeLon;
  String age;
  String driverName;
  String driverPhone;

  ChildInfo(
      {this.name,
      this.age,
      this.id,
      this.phone,
      this.homeAdd,
      this.schoolAdd,
      this.schoolLat,
      this.schoolLon,
      this.homeLat,
      this.homeLon,
      this.driverName,
      this.driverPhone});
  factory ChildInfo.fromjson(Map<String, dynamic> json) {
    return ChildInfo(
      name: json['full_name'] != null ? json['full_name'] : '',
      id: json['id'] != null ? json['id'] : '',
      phone: json['phone1'] != null ? json['phone1'] : '',
      homeAdd: json['home_address'] != null ? json['home_address'] : '',
      homeLon: json['lon'] != null ? json['lon'] : '',
      homeLat: json['lat'] != null ? json['lat'] : '',
      schoolAdd: json['school_name'] != null ? json['school_name'] : '',
      schoolLat: json['school_lat'] != null ? json['school_lat'] : '',
      schoolLon: json['school_lon'] != null ? json['school_lon'] : '',
      age: json['age'] != null ? json['age'] : '',
      driverName: json['driver_name'] != null ? json['driver_name'] : '',
      driverPhone: json['driver_phone'] != null ? json['driver_phone'] : '',
    );
  }
}

class ChildList {
  final List<dynamic> studentList;
  ChildList({this.studentList});

  factory ChildList.fromjson(Map<String, dynamic> json) {
    return ChildList(
      studentList: json['child'] != null ? json['child'] : '',
    );
  }
}
