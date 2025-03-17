import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:salonmate/services/address_service.dart';
import 'package:salonmate/screens/profile/YeniAdresEkleScreen.dart';
import 'package:salonmate/widgets/empty.dart';

class AdreslerimScreen extends StatefulWidget {
  const AdreslerimScreen({Key? key}) : super(key: key);

  @override
  State<AdreslerimScreen> createState() => _AdreslerimScreenState();
}

class _AdreslerimScreenState extends State<AdreslerimScreen> {
  final AddressService _addressService = AddressService();
  bool _isLoading = true;
  List<Address> _addresses = [];

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() => _isLoading = true);
    try {
      final addresses = await _addressService.listAddresses();
      setState(() => _addresses = addresses);
    } catch (e) {
      _showError(e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _confirmDelete(Address address) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(('AdreslerimScreen.delete_confirmation_title').tr()),
          content: Text(('AdreslerimScreen.delete_confirmation_message').tr()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                ('AdreslerimScreen.cancel').tr(),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                ('AdreslerimScreen.delete').tr(),
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAddress(address);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAddress(Address address) async {
    try {
      await _addressService.deleteAddress(address.id);
      _showSuccess(('AdreslerimScreen.delete_success').tr());
      await _loadAddresses(); // Reload addresses after successful deletion
    } catch (e) {
      _showError(e.toString());
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccess(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text(('AdreslerimScreen.my_addresses').tr()),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YeniAdresEkleScreen(),
                  ),
                );
                if (result == true) {
                  _loadAddresses();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_location_alt_outlined, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    ('AdreslerimScreen.add_new_address').tr(),
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _addresses.isEmpty
                    ? EmptyState(
                        image: "assets/images/icons/home.png",
                        title: ('AdreslerimScreen.no_addresses').tr(),
                        description:
                            ('AdreslerimScreen.add_address_description').tr(),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: _addresses.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final address = _addresses[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${address.city}, ${address.state}',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    address.address,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${address.zipCode}, ${address.country}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  Divider(height: 1, color: Color(0xFFE5E7EB)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  YeniAdresEkleScreen(
                                                address: address,
                                              ),
                                            ),
                                          ).then((value) {
                                            if (value == true) {
                                              _loadAddresses();
                                            }
                                          });
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                        child: Text(
                                          ('AdreslerimScreen.edit').tr(),
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      TextButton(
                                        onPressed: () =>
                                            _confirmDelete(address),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        child: Text(
                                          ('AdreslerimScreen.delete').tr(),
                                          style: TextStyle(fontSize: 14.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
