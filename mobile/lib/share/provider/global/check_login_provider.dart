import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/share/data/datasources/global/check_login_datasource.dart';

@injectable
class CheckLoginProvider extends ChangeNotifier {
  final CheckLoginDatasource checkLoginDatasource;

  // SYNC constructor
  CheckLoginProvider({required this.checkLoginDatasource});

  bool _isLogin = false;
  bool get isLogin => _isLogin;

  Future<void> checkIsLogin() async {
    _isLogin = await checkLoginDatasource.checkIsLogin();
    notifyListeners();
  }
}
