import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/config/constant.dart';
import 'package:mobile/core/helper/format_date.dart';
import 'package:mobile/features/order/domain/usecase/order/get_order.dart';
import 'package:mobile/share/data/models/order/order.dart' as OrderModel;
import 'package:mobile/share/data/models/paginated/paginated.dart';

@injectable
class OrderProvider extends ChangeNotifier {
  final GetOrderUseCase getOrderUseCase;

  // SYNC constructor
  OrderProvider(
    this.getOrderUseCase,
  );

  // Orders state
  Paginated<OrderModel.Order>? _orders;
  Paginated<OrderModel.Order>? get orders => _orders;
  List<OrderModel.Order> get ordersList => _orders?.data ?? [];

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _message;
  String? get message => _message;

  // Pagination state
  int _currentPage = 1;
  int get currentPage => _currentPage;
  
  int? _totalPages;
  int get totalPages => _totalPages ?? 1;

  // Search filters
  DateTime? _startDate;
  DateTime? get startDate => _startDate;

  DateTime? _endDate;
  DateTime? get endDate => _endDate;

  int? _selectedStatus;
  int? get selectedStatus => _selectedStatus;

  /// Set start date filter
  ///
  /// @param DateTime? date
  ///
  /// @return void
  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }

  /// Set end date filter
  ///
  /// @param DateTime? date
  ///
  /// @return void
  void setEndDate(DateTime? date) {
    _endDate = date;
    notifyListeners();
  }

  /// Set status filter
  ///
  /// @param int? status
  ///
  /// @return void
  void setStatus(int? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  /// Clear all filters
  ///
  /// @return void
  void clearFilters() {
    _startDate = null;
    _endDate = null;
    _selectedStatus = null;
    notifyListeners();
  }

  /// Get list of orders
  /// 
  /// @param int page
  ///
  /// @return Future<void>
  Future<void> getOrders({int page = 1}) async {
    _isLoading = true;
    notifyListeners();

    final params = OrderParams(
      page: page,
      limit: AppConstants.LIMIT_ORDER,
      column: 'created_at',
      order: AppConstants.DEFAULT_ORDER,
      startDate: _startDate != null ? formatDay(_startDate!) : null,
      endDate: _endDate != null ? formatDay(_endDate!) : null,
      status: _selectedStatus,
    );

    final response = await getOrderUseCase(params);
    
    if (response.success && response.data != null) {
      _orders = response.data;
      _currentPage = page;
      _totalPages = response.data!.lastPage;
    } else {
      _orders = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Search orders with current filters
  ///
  /// @return Future<void>
  Future<void> searchOrders() async {
    await getOrders(page: 1);
  }

  /// Change page
  ///
  /// @param int page
  ///
  /// @return Future<void>
  Future<void> changePage(int page) async {
    if (page >= 1 && page <= totalPages) {
      await getOrders(page: page);
    }
  }
}
