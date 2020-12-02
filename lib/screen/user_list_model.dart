import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api/service/database_services.dart';

import '../user_model.dart';

class UserListModel extends ChangeNotifier{
  List<User> userList = [];
  User user = User();
  final _dbServices = DatabaseServices();
 bool isLoading = true;
 Response response;
  UserListModel(){
    getUser();
  }

  getUser() async{
//    isLoading=false;
    userList = await _dbServices.getUser();
    if(userList == null && userList.length < 1){
      print("No Data in userList");
    }
    userList.forEach((element) {print("@get User model $userList");});
    isLoading=false;

    notifyListeners();
  }

  addUser() async{

    try{
      response = await _dbServices.addUser(user);
      if(response != null){
        userList.add(user);

      }
    }catch(e){
      print("exception in model $e");
    }
    notifyListeners();
  }

  deleteUser(User userDetail) async{
    try{
      response = await _dbServices.deletedUser(userDetail);
      if(response != null){
        print(userDetail);
        userList.remove(userDetail);
      }
    }catch(e){
      print("exception in delete $e");
    }
    notifyListeners();
  }

  updateUser(User userDetail) async{
    try{
      response = await _dbServices.deletedUser(userDetail);
      if(response != null){
        print(userDetail);
        userList.remove(userDetail);
      }
    }catch(e){
      print("exception in delete $e");
    }
    notifyListeners();
  }
}