import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:salonmate/services/address_service.dart';

class YeniAdresEkleScreen extends StatefulWidget {
  final Address? address;

  const YeniAdresEkleScreen({Key? key, this.address}) : super(key: key);

  @override
  State<YeniAdresEkleScreen> createState() => _YeniAdresEkleScreenState();
}

class _YeniAdresEkleScreenState extends State<YeniAdresEkleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressService = AddressService();

  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _zipCodeController;
  late TextEditingController _countryController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.address?.address);
    _cityController = TextEditingController(text: widget.address?.city);
    _stateController = TextEditingController(text: widget.address?.state);
    _zipCodeController = TextEditingController(text: widget.address?.zipCode);
    _countryController = TextEditingController(text: widget.address?.country);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      if (widget.address == null) {
        await _addressService.addAddress(
          address: _addressController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipCodeController.text,
          country: _countryController.text,
        );
      } else {
        await _addressService.updateAddress(
          addressID: widget.address!.id,
          address: _addressController.text,
          city: _cityController.text,
          state: _stateController.text,
          zipCode: _zipCodeController.text,
          country: _countryController.text,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(('YeniAdresEkleScreen.success').tr())),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.address == null
            ? ('YeniAdresEkleScreen.title').tr()
            : ('YeniAdresEkleScreen.edit_title').tr()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            TextFormField(
              controller: _countryController,
              decoration: InputDecoration(
                labelText: ('YeniAdresEkleScreen.country').tr(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return ('YeniAdresEkleScreen.required_field').tr();
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _stateController,
              decoration: InputDecoration(
                labelText: ('YeniAdresEkleScreen.city').tr(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return ('YeniAdresEkleScreen.required_field').tr();
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: ('YeniAdresEkleScreen.town').tr(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return ('YeniAdresEkleScreen.required_field').tr();
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _zipCodeController,
              decoration: InputDecoration(
                labelText: ('YeniAdresEkleScreen.phone').tr(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return ('YeniAdresEkleScreen.required_field').tr();
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: _addressController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: ('YeniAdresEkleScreen.address_detail').tr(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return ('YeniAdresEkleScreen.required_field').tr();
                }
                return null;
              },
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _isLoading ? null : _saveAddress,
              child: _isLoading
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(('YeniAdresEkleScreen.save').tr()),
            ),
          ],
        ),
      ),
    );
  }
}
