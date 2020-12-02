import 'package:dio/dio.dart';
import 'package:flutter_rest_api/user_model.dart';

class DatabaseServices {
  final basePoint = "https://5fc605544931580016e3c7a6.mockapi.io/test1";

  /// getUser
  getUser() async{
    Dio dio = Dio();
    List<User> userList = [];
    try{
      Response response = await dio.get("$basePoint/crud");
      print("@getUser $response");

      response.data.forEach((e){
        userList.add(User.fromJson(e));


      });
      if(response!=null){
        return userList;
      }else{
        return response;
      }
    }catch(e){
      print("@getUser $e");
    }
  }

  addUser(User user) async{
    Dio dio = Dio();
    try{
      Response response = await dio.post("$basePoint/crud",
      data: user.toJson());
      print(response);
      if(response != null){
        return response;
      }
    }catch(e){
      print("@AddUser $e");
    }
  }
}