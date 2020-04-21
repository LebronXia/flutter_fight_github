import 'package:flutter/cupertino.dart';
import 'package:flutterfightgithub/data/models/user.dart';
import 'package:flutterfightgithub/utils/storage_manager.dart';

class UserModel extends ChangeNotifier{

  static const String XUser = "XUser";

  User _user;

  User get user => _user;

  bool get hasUser => user != null;

  UserModel(){
    var userMap = StorageManager.localStorage.getItem(XUser);
    _user = userMap != null ? User.fromJson(userMap) : null;
  }

  saveUser(User user){
    _user = user;
    StorageManager.localStorage.setItem(XUser, user);
    notifyListeners();
  }

  clearUser(){
    _user = null;
    StorageManager.localStorage.deleteItem(XUser);
    notifyListeners();
  }

}