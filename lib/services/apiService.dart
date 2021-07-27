import 'package:app01/forMe/models/login_model.dart';
import 'package:app01/forMe/models/parentChiled_model.dart';
import 'package:app01/forMe/models/studentinfo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class APIServise {
  Future<LoginResponseModel> fetchProfileData(
      Map<String, dynamic> requestModel) async {
    var url = Uri.parse('https://herobus.000webhostapp.com/api/login.php');
    final response = await http.post(url, body: requestModel);
    if (response.statusCode == 200 || response.statusCode == 400) {
      var dejson = LoginResponseModel.fromjson(jsonDecode(response.body));
      return dejson;
    } else {
      throw Exception('faild to load Data');
    }
  }

  Future<List<StudentsInfo>> fetchStudentInfo(
      Map<String, dynamic> request) async {
    var url =
        Uri.parse('https://herobus.000webhostapp.com/api/studentdriver.php');
    final response = await http.post(url, body: request);

    if (response.statusCode == 200 || response.statusCode == 400) {
      StudenstDetal data = StudenstDetal.fromjson(jsonDecode(response.body));
      List<StudentsInfo> stList =
          data.studentList.map((e) => StudentsInfo.fromjson(e)).toList();
      return stList;
    } else {
      throw Exception('faild to load Data');
    }
  }

  Future<List<ChildInfo>> fetchChildInfo(Map<String, dynamic> request) async {
    var url =
        Uri.parse('https://herobus.000webhostapp.com/api/parentChild.php');
    final response = await http.post(url, body: request);

    if (response.statusCode == 200 || response.statusCode == 400) {
      ChildList data = ChildList.fromjson(jsonDecode(response.body));
      List<ChildInfo> stList =
          data.studentList.map((e) => ChildInfo.fromjson(e)).toList();
      return stList;
    } else {
      throw Exception('faild to load Data');
    }
  }

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    var url = Uri.parse('https://herobus.000webhostapp.com/api/login.php');
    final response = await http.post(url, body: requestModel.toJson());

    if (response.statusCode == 200 || response.statusCode == 400) {
      var dejson = LoginResponseModel.fromjson(jsonDecode(response.body));
      return dejson;
    } else {
      throw Exception('faild to load Data');
    }
  }
}

/* class LoginRequest {
  static getRequest() async {
    var url = Uri.parse('http://jsonplaceholder.typicode.com/users');

    http.Response responce = await http.get(url);
    print(responce.statusCode);
    if (responce.statusCode == 200) {
      var decodeData = convert.jsonDecode(responce.body);

      return decodeData;
    } else {
      return "Faild";
    }
  }
} */
