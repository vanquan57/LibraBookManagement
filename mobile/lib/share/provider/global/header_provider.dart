import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/auth/domain/usecases/post_logout.dart';

@injectable
class HeaderProvider extends ChangeNotifier {
  final PostLogoutUseCase postLogoutUseCase;
  final LocalStorageService localStorageService;

  // SYNC constructor
  HeaderProvider({required this.postLogoutUseCase, required this.localStorageService});

  String _querySearch = '';
  String get querySearch => _querySearch;

  /// Clear query search
  ///
  /// @return void
  void clearQuerySearch() {
    _querySearch = '';
    notifyListeners();
  }

  /// Set query search
  ///
  /// @param String query
  /// @return void
  void setQuerySearch(String query) {
    _querySearch = query;
    notifyListeners();
  }

  /// Logout user
  ///
  /// @return Future<bool>
  Future<bool> logout() async {
    final response = await postLogoutUseCase();
    if (response.success) {
      await localStorageService.clear();  
      return true;
    } else {
      return false;
    }
  }
}
