import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/net/data_result.dart';
import 'package:flutterfightgithub/data/repository/user_repository.dart';
import 'package:flutterfightgithub/view_model/user_model.dart';

class LoginModel extends ChangeNotifier{

  final UserModel userModel;
  bool _progressVisible;

  LoginModel(this.userModel) : assert(userModel != null);

  bool get progressVisible => _progressVisible;

  Future<bool> login(loginName, password) async{
    try{
      var user = await UserRepository.login(loginName, password);
      if(user != null && user.result){
        userModel.saveUser(user.data.data);
        return true;
      } else {
        return false;
      }
    } catch(e, s){
      return false;
    }
  }

  void updateProgressVisible(final bool visible) {
    if (_progressVisible != visible) {
      _progressVisible = visible;
      notifyListeners();
    }
  }
}