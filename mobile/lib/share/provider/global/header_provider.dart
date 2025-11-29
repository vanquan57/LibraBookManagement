import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HeaderProvider extends ChangeNotifier {
  // SYNC constructor
  HeaderProvider();

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
}
