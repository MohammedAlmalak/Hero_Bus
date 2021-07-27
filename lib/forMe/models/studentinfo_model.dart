class StudentsInfo {
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

  StudentsInfo(
      {this.name,
      this.age,
      this.id,
      this.phone,
      this.homeAdd,
      this.schoolAdd,
      this.schoolLat,
      this.schoolLon,
      this.homeLat,
      this.homeLon});
  factory StudentsInfo.fromjson(Map<String, dynamic> json) {
    return StudentsInfo(
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
    );
  }
}

class StudenstDetal {
  final List<dynamic> studentList;
  StudenstDetal({this.studentList});

  factory StudenstDetal.fromjson(Map<String, dynamic> json) {
    return StudenstDetal(
      studentList: json['student'] != null ? json['student'] : '',
    );
  }
}
