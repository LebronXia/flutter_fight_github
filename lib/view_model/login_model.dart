import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/net/data_result.dart';
import 'package:flutterfightgithub/data/repository/user_repository.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';

class LoginModel extends ChangeNotifier{

  final UserModel userModel;

  LoginModel(this.userModel) : assert(userModel != null);

  Future<bool> login(loginName, password) async{
    try{
      var user = await UserRepository.login(loginName, password);
      if(user != null && user.result){
        userModel.saveUser(user.data);
        return true;
      }
    } catch(e, s){
      return false;
    }
  }
}