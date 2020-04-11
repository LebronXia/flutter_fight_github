import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/model/user.dart';
import 'package:flutterfightgithub/utils/storage_manager.dart';

class UserModel extends ChangeNotifier{

  static const String XUser = "XUser";

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  saveUser(User user){
    _user = user;
    notifyListeners();
    StorageManager.localStorage.setItem(XUser, user);
  }

  clearUser(){
    _user = null;
    StorageManager.localStorage.deleteItem(XUser);
  }

}