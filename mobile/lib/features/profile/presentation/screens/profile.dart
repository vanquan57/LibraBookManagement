import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/core/router/app_router.dart';
import 'package:mobile/core/utils/validators.dart';
import 'package:mobile/features/profile/presentation/provider/profile_provider.dart';
import 'package:mobile/share/components/styled_dialog.dart';
import 'package:provider/provider.dart';
import 'package:mobile/core/helper/protected_route.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _employeeCodeController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();

  // Selected values for dropdowns (storing IDs)
  int? _selectedProvinceId;
  int? _selectedDistrictId;
  int? _selectedWardId;

  // Lists for dropdowns
  List<Map<String, dynamic>> _districts = [];
  List<Map<String, dynamic>> _wards = [];

  // Store original values to detect changes
  Map<String, dynamic>? _originalValues;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _employeeCodeController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  /// Initialize data (fetch user profile, provinces, etc.)
  ///
  /// @return void
  void _initializeData() async {
    if (!mounted) return;

    final profileProvider = context.read<ProfileProvider>();

    // Fetch provinces
    await profileProvider.getProvinces();

    // Fetch user profile
    await profileProvider.getInformationUser();

    if (mounted && profileProvider.userInformation != null) {
      final user = profileProvider.userInformation!;

      // Set basic info first
      _nameController.text = user.name;
      _employeeCodeController.text = user.code;
      _emailController.text = user.email;
      _addressController.text = user.address ?? '';

      // Store original values for comparison
      _originalValues = {
        'name': user.name,
        'province_id': user.provinceId,
        'district_id': user.districtId,
        'ward_id': user.wardId,
        'address': user.address ?? '',
      };

      // Load districts based on user's province
      // Find province in loaded provinces list to get code
      if (user.provinceId != null) {
        try {
          final selectedProvince = profileProvider.provinces.firstWhere(
            (province) => province.id == user.provinceId,
          );

          if (selectedProvince.code != null) {
            await profileProvider.getDistricts(selectedProvince.code!);

            if (mounted) {
              setState(() {
                _districts = profileProvider.districts
                    .map(
                      (district) => {
                        'id': district.id,
                        'name': district.name,
                        'code': district.code,
                      },
                    )
                    .toList();
              });
            }

            // Load wards based on user's district
            // Find district in loaded districts list to get code
            if (user.districtId != null) {
              try {
                final selectedDistrict = profileProvider.districts.firstWhere(
                  (district) => district.id == user.districtId,
                );

                if (selectedDistrict.code != null) {
                  await profileProvider.getWards(selectedDistrict.code!);

                  if (mounted) {
                    setState(() {
                      _wards = profileProvider.wards
                          .map(
                            (ward) => {
                              'id': ward.id,
                              'name': ward.name,
                              'code': ward.code,
                            },
                          )
                          .toList();
                    });
                  }
                }
              } catch (e) {
                debugPrint('Error finding district: $e');
              }
            }
          }
        } catch (e) {
          debugPrint('Error finding province: $e');
        }
      }

      // Set selected values AFTER loading districts and wards
      if (mounted) {
        setState(() {
          _selectedProvinceId = user.provinceId;
          _selectedDistrictId = user.districtId;
          _selectedWardId = user.wardId;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) {
        if (profileProvider.isLoading) {
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return Container(
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
              child: Column(
                children: [
                  // Breadcrumb with change password button
                  _buildBreadcrumb(profileProvider),
                  SizedBox(height: 16.h),

                  // User Information Form
                  _buildUserInformationForm(profileProvider),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Build breadcrumb with change password button
  ///
  /// @param ProfileProvider profileProvider
  ///
  /// @return Widget
  Widget _buildBreadcrumb(ProfileProvider profileProvider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Breadcrumb navigation
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Chào bạn',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4.w),
              Text(
                '${profileProvider.userInformation?.name ?? ''}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Change password button
          TextButton.icon(
            onPressed: () async {
              if (await ensureLogin(context)) {
                context.push(AppRouter.changePassword);
              }
            },
            icon: const Icon(Icons.lock_outline, size: 18),
            label: const Text('Đổi mật khẩu'),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFF6E38),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            ),
          ),
        ],
      ),
    );
  }

  /// Build user information form
  ///
  /// @param ProfileProvider profileProvider
  ///
  /// @return Widget
  Widget _buildUserInformationForm(ProfileProvider profileProvider) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cập nhật thông tin tài khoản',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF6E38),
              ),
            ),
            SizedBox(height: 16.h),

            // Email and Employee Code (Disabled fields in row)
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Email',
                    controller: _emailController,
                    enabled: false,
                    validator: null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildTextField(
                    label: 'Mã sinh viên',
                    controller: _employeeCodeController,
                    enabled: false,
                    validator: null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Name and Province (Row)
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    label: 'Họ tên',
                    controller: _nameController,
                    validator: Validators.fullName,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildDropdownField(
                    label: 'Tỉnh thành',
                    value: _selectedProvinceId,
                    items: profileProvider.provinces
                        .map(
                          (province) => {
                            'id': province.id,
                            'name': province.name,
                            'code': province.code,
                          },
                        )
                        .toList(),
                    onChanged: (value) async {
                      setState(() {
                        _selectedProvinceId = value;
                        _selectedDistrictId = null;
                        _selectedWardId = null;
                        _districts = [];
                        _wards = [];
                      });

                      if (value != null) {
                        // Find province by ID and get its code
                        final selectedProvince = profileProvider.provinces
                            .firstWhere((province) => province.id == value);

                        if (selectedProvince.code != null) {
                          await profileProvider.getDistricts(
                            selectedProvince.code!,
                          );

                          setState(() {
                            _districts = profileProvider.districts
                                .map(
                                  (district) => {
                                    'id': district.id,
                                    'name': district.name,
                                    'code': district.code,
                                  },
                                )
                                .toList();
                          });
                        }
                      }
                    },
                    validator: (value) =>
                        Validators.dropdown(value, 'tỉnh thành'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // District and Ward (Row)
            Row(
              children: [
                Expanded(
                  child: _buildDropdownField(
                    label: 'Quận huyện',
                    value: _selectedDistrictId,
                    items: _districts,
                    onChanged: (value) async {
                      setState(() {
                        _selectedDistrictId = value;
                        _selectedWardId = null;
                        _wards = [];
                      });

                      if (value != null) {
                        // Find district by ID and get its code
                        final selectedDistrict = _districts.firstWhere(
                          (district) => district['id'] == value,
                        );
                        final districtCode =
                            selectedDistrict['code'] as String?;

                        if (districtCode != null) {
                          await profileProvider.getWards(districtCode);

                          setState(() {
                            _wards = profileProvider.wards
                                .map(
                                  (ward) => {
                                    'id': ward.id,
                                    'name': ward.name,
                                    'code': ward.code,
                                  },
                                )
                                .toList();
                          });
                        }
                      }
                    },
                    validator: (value) =>
                        Validators.dropdown(value, 'quận huyện'),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildDropdownField(
                    label: 'Xã phường',
                    value: _selectedWardId,
                    items: _wards,
                    onChanged: (value) {
                      setState(() {
                        _selectedWardId = value;
                      });
                    },
                    validator: (value) =>
                        Validators.dropdown(value, 'xã phường'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Address Field (Full width)
            _buildTextField(
              label: 'Địa chỉ',
              controller: _addressController,
              maxLines: 2,
              validator: Validators.address,
            ),
            SizedBox(height: 24.h),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel button
                OutlinedButton(
                  onPressed: _handleCancel,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    side: BorderSide(color: Colors.grey[300]!),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text('Hủy', style: TextStyle(fontSize: 14.sp)),
                ),
                SizedBox(width: 12.w),
                // Update button
                ElevatedButton(
                  onPressed: () async {
                    if (await ensureLogin(context)) {
                      _handleUpdate(profileProvider);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6E38),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Cập nhật',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Build text field
  ///
  /// @param String label
  /// @param TextEditingController controller
  /// @param bool enabled
  /// @param TextInputType keyboardType
  /// @param int maxLines
  /// @param String? Function(String?)? validator
  ///
  /// @return Widget
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool enabled = true,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            children: [
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          key: ValueKey(controller.text),
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(
            fontSize: 14.sp,
            color: enabled ? Colors.black87 : Colors.black54,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey[100],
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFFF6E38)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }

  /// Build dropdown field
  ///
  /// @param String label
  /// @param int? value
  /// @param List<Map<String, dynamic>> items
  /// @param void Function(int?)? onChanged
  /// @param String? Function(int?)? validator
  ///
  /// @return Widget
  Widget _buildDropdownField({
    required String label,
    required int? value,
    required List<Map<String, dynamic>> items,
    required void Function(int?)? onChanged,
    String? Function(int?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
            children: [
              if (validator != null)
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
            ],
          ),
        ),
        SizedBox(height: 6.h),
        DropdownButtonFormField<int>(
          value: value,
          validator: validator,
          dropdownColor: Colors.white,
          menuMaxHeight: 300.h,
          isExpanded: true,
          isDense: false,
          style: TextStyle(fontSize: 14.sp, color: Colors.black87),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.grey[700],
            size: 24.sp,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 2.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Color(0xFFFF6E38)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          hint: Text(
            'Chọn $label',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          items: items.map((item) {
            return DropdownMenuItem<int>(
              value: item['id'] as int,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  item['name'] as String,
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  maxLines: 1,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// Handle cancel button - reset form to original values
  ///
  /// @return void
  void _handleCancel() async {
    if (_originalValues != null) {
      final profileProvider = context.read<ProfileProvider>();

      _nameController.text = _originalValues!['name'];
      _addressController.text = _originalValues!['address'];

      // Check if province changed, if yes, reload districts
      if (_selectedProvinceId != _originalValues!['province_id']) {
        if (_originalValues!['province_id'] != null) {
          try {
            // Find province in loaded provinces list to get code
            final selectedProvince = profileProvider.provinces.firstWhere(
              (province) => province.id == _originalValues!['province_id'],
            );

            if (selectedProvince.code != null) {
              await profileProvider.getDistricts(selectedProvince.code!);

              if (mounted) {
                setState(() {
                  _districts = profileProvider.districts
                      .map(
                        (district) => {
                          'id': district.id,
                          'name': district.name,
                          'code': district.code,
                        },
                      )
                      .toList();
                });
              }
            }
          } catch (e) {
            debugPrint('Error finding province: $e');
          }
        }
      }

      // Check if district changed, if yes, reload wards
      if (_selectedDistrictId != _originalValues!['district_id']) {
        if (_originalValues!['district_id'] != null) {
          try {
            // Find district in loaded districts list to get code
            final selectedDistrict = profileProvider.districts.firstWhere(
              (district) => district.id == _originalValues!['district_id'],
            );

            if (selectedDistrict.code != null) {
              await profileProvider.getWards(selectedDistrict.code!);

              if (mounted) {
                setState(() {
                  _wards = profileProvider.wards
                      .map(
                        (ward) => {
                          'id': ward.id,
                          'name': ward.name,
                          'code': ward.code,
                        },
                      )
                      .toList();
                });
              }
            }
          } catch (e) {
            debugPrint('Error finding district: $e');
          }
        }
      }

      // Reset selected values
      if (mounted) {
        setState(() {
          _selectedProvinceId = _originalValues!['province_id'];
          _selectedDistrictId = _originalValues!['district_id'];
          _selectedWardId = _originalValues!['ward_id'];
        });
      }
    }
  }

  /// Handle update button - validate and submit form
  ///
  /// @return void
  Future<void> _handleUpdate(ProfileProvider profileProvider) async {
    if (_formKey.currentState!.validate()) {
      // Check if there are any changes
      bool hasChanges =
          _nameController.text != _originalValues!['name'] ||
          _addressController.text != _originalValues!['address'] ||
          _selectedProvinceId != _originalValues!['province_id'] ||
          _selectedDistrictId != _originalValues!['district_id'] ||
          _selectedWardId != _originalValues!['ward_id'];

      if (!hasChanges) {
        if (!mounted) return;
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => StyledDialog(
            message: 'Không có thay đổi nào được tìm thấy',
            isSuccess: false,
          ),
        );

        return;
      }

      // Prepare data for submission
      final formData = {
        'name': _nameController.text,
        'province_id': _selectedProvinceId,
        'district_id': _selectedDistrictId,
        'ward_id': _selectedWardId,
        'address': _addressController.text,
      };

      await profileProvider.updateProfile(formData);

      if (profileProvider.message != null && profileProvider.isShowDialog) {
        if (!mounted) return;

        final successMessage = profileProvider.message!;
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              StyledDialog(message: successMessage, isSuccess: true),
        );
      } else if (profileProvider.errorMessage != null &&
          profileProvider.isShowDialog) {
        if (!mounted) return;

        final errorMessage = profileProvider.errorMessage!;
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) =>
              StyledDialog(message: errorMessage, isSuccess: false),
        );

        profileProvider.resetDialogState();
      }
      
      await profileProvider.getInformationUser();
    }
  }
}
