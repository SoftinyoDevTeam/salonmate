import 'dart:convert';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:salonmate/services/address_service.dart';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/core/models/othermodels/radioselectmodels.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:salonmate/widgets/cards/receiptwidget.dart';
import 'package:salonmate/widgets/cards/selectedlocationwidget.dart';
import 'package:web_socket_client/web_socket_client.dart' as ws_client;
import 'package:webview_flutter/webview_flutter.dart';

// Define the Branch class
class Branch {
  final int ID;
  final String name;
  final String address;

  Branch({required this.ID, required this.name, required this.address});
}

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key, required this.subTotal});
  final int subTotal;

  @override
  State<StatefulWidget> createState() => PaymentFormState();
}

// Add enum for delivery types
enum DeliveryType { branch, shipping }

class PaymentFormState extends State<PaymentForm> {
  List<RadioSelectModels?> subeler = [];
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  WebViewController wbController = WebViewController();
  bool loading = false;
  Widget loadingWidget = Center(
    child: CircularProgressIndicator(),
  );
  final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
    color: Colors.grey.withOpacity(0.7),
    width: 2.0,
  ));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void initstate() {}

  // Add new properties for delivery option
  DeliveryType _selectedDeliveryType = DeliveryType.branch;

  // Add this property to PaymentFormState class
  Branch? _selectedBranch;
  Branch? _selectedAddress;

  void fetchSubeler() async {
    subeler = await checkRadioList("getAllSubeMobile", FormData.fromMap({}));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSubeler();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return Scaffold(
      resizeToAvoidBottomInset: true, // Changed from false to true
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: loading
                ? loadingWidget
                : SingleChildScrollView(
                    // Add this wrapper
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(16.w),
                                child: Text(
                                  ('PaymentScreen.delivery_method').tr(),
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              RadioListTile<DeliveryType>(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ('PaymentScreen.branch_delivery').tr(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    if (_selectedDeliveryType ==
                                        DeliveryType.branch)
                                      TextButton.icon(
                                        onPressed: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ListView.builder(
                                                itemCount: subeler.length,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  final branch = subeler[index];
                                                  return ListTile(
                                                    title: Text(
                                                        branch?.fullName ?? ''),
                                                    subtitle: Text(
                                                        branch?.fullName ?? ''),
                                                    onTap: () {
                                                      setState(() {
                                                        _selectedBranch =
                                                            Branch(
                                                          ID: branch!.ID!,
                                                          name: branch
                                                                  ?.fullName ??
                                                              '',
                                                          address: branch
                                                                  ?.fullName ??
                                                              '',
                                                        );
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.store,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        label: Text(
                                          _selectedBranch == null
                                              ? ('PaymentScreen.select_branch')
                                                  .tr()
                                              : ('PaymentScreen.change_branch')
                                                  .tr(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_selectedBranch != null)
                                      SelectedLocationWidget(
                                          selectedBranch: _selectedBranch!)
                                  ],
                                ),
                                value: DeliveryType.branch,
                                groupValue: _selectedDeliveryType,
                                onChanged: (DeliveryType? value) {
                                  setState(() {
                                    _selectedDeliveryType = value!;
                                  });
                                },
                              ),
                              RadioListTile<DeliveryType>(
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ('PaymentScreen.shipping').tr(),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    if (_selectedDeliveryType ==
                                        DeliveryType.shipping)
                                      TextButton.icon(
                                        onPressed: () async {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return FutureBuilder<
                                                  List<Address>>(
                                                future: AddressService()
                                                    .listAddresses(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                        child: Text(
                                                            'Error: ${snapshot.error}'));
                                                  } else if (!snapshot
                                                          .hasData ||
                                                      snapshot.data!.isEmpty) {
                                                    return Center(
                                                        child: Text(
                                                            'No addresses found.'));
                                                  } else {
                                                    final addresses =
                                                        snapshot.data!;
                                                    return ListView.builder(
                                                      itemCount:
                                                          addresses.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final address =
                                                            addresses[index];
                                                        return ListTile(
                                                          title: Text(
                                                              address.address),
                                                          subtitle: Text(
                                                              address.city),
                                                          onTap: () {
                                                            setState(() {
                                                              _selectedAddress =
                                                                  Branch(
                                                                ID: int.parse(
                                                                    address!
                                                                        .id!),
                                                                name: address
                                                                    .address,
                                                                address: address
                                                                    .city,
                                                              );
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.store,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        label: Text(
                                          _selectedBranch == null
                                              ? ('PaymentScreen.select_adress')
                                                  .tr()
                                              : ('PaymentScreen.change_adress')
                                                  .tr(),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (_selectedAddress != null)
                                      SelectedLocationWidget(
                                          selectedBranch: _selectedAddress!)
                                  ],
                                ),
                                value: DeliveryType.shipping,
                                groupValue: _selectedDeliveryType,
                                onChanged: (DeliveryType? value) {
                                  setState(() {
                                    _selectedDeliveryType = value!;
                                    _selectedBranch = null;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        OrderSummaryWidget(
                          subtotal: widget.subTotal
                              .toDouble(), // Replace with your actual values
                          shippingFee: _selectedDeliveryType ==
                                      DeliveryType.branch ||
                                  int.parse(Provider.of<MateServices>(context,
                                              listen: false)
                                          .salonConfig!
                                          .data!
                                          .salonConfig!
                                          .minimumsepet!) <=
                                      widget.subTotal
                              ? 0
                              : Provider.of<MateServices>(context,
                                      listen: false)
                                  .salonConfig!
                                  .data!
                                  .salonConfig!
                                  .kargoucreti!,
                          serviceFee: 0,
                          tax: widget.subTotal * 0.18,
                        ),
                        CreditCardWidget(
                          labelValidThru: "",
                          enableFloatingCard: useFloatingAnimation,
                          glassmorphismConfig: _getGlassmorphismConfig(),
                          cardNumber: cardNumber,
                          expiryDate: expiryDate,
                          labelCardHolder:
                              ("PaymentScreen.card_holder_name").tr(),
                          labelExpiredDate: ("PaymentScreen.expiry_date").tr(),
                          cardHolderName: cardHolderName,
                          cvvCode: cvvCode,
                          bankName: 'SALONMATE',
                          frontCardBorder: useGlassMorphism
                              ? null
                              : Border.all(color: Colors.grey),
                          backCardBorder: useGlassMorphism
                              ? null
                              : Border.all(color: Colors.grey),
                          showBackView: isCvvFocused,
                          obscureCardNumber: false,
                          obscureCardCvv: false,
                          isHolderNameVisible: true,
                          cardBgColor: isLightTheme
                              ? Theme.of(context).primaryColorLight
                              : Theme.of(context).primaryColorLight,
                          backgroundImage: useBackgroundImage
                              ? 'assets/images/backgrounds/card_bg.png'
                              : 'assets/images/backgrounds/card_bg.png',
                          isSwipeGestureEnabled: true,
                          onCreditCardWidgetChange:
                              (CreditCardBrand creditCardBrand) {},
                          customCardTypeIcons: <CustomCardTypeIcon>[
                            CustomCardTypeIcon(
                              cardType: CardType.mastercard,
                              cardImage: Image.asset(
                                'assets/images/backgrounds/mastercard.png',
                                height: 48,
                                width: 48,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: <Widget>[
                              // Add delivery options before credit card form

                              CreditCardForm(
                                formKey: formKey,
                                obscureCvv: false,
                                obscureNumber: false,
                                cardNumber: cardNumber,
                                cvvCode: cvvCode,
                                isHolderNameVisible: true,
                                isCardNumberVisible: true,
                                isExpiryDateVisible: true,
                                cardHolderName: cardHolderName,
                                expiryDate: expiryDate,
                                inputConfiguration: InputConfiguration(
                                  cardNumberDecoration: InputDecoration(
                                    labelText:
                                        ("PaymentScreen.card_number").tr(),
                                    hintText: 'XXXX XXXX XXXX XXXX',
                                  ),
                                  expiryDateDecoration: InputDecoration(
                                    labelText:
                                        ("PaymentScreen.expiry_date").tr(),
                                    hintText: 'XX/XX',
                                  ),
                                  cvvCodeDecoration: InputDecoration(
                                    labelText: ("PaymentScreen.cvv").tr(),
                                    hintText: 'XXX',
                                  ),
                                  cardHolderDecoration: InputDecoration(
                                    labelText:
                                        ("PaymentScreen.card_holder_name").tr(),
                                  ),
                                ),
                                onCreditCardModelChange:
                                    onCreditCardModelChange,
                              ),
                              SizedBox(height: 20),
                              MateButon(
                                  title: ("PaymentScreen.pay_now").tr(),
                                  minimumSize:
                                      Size(ScreenUtil().screenWidth - 30.w, 50),
                                  onPressed: _onValidate,
                                  color: Theme.of(context).primaryColor,
                                  textcolor:
                                      Theme.of(context).primaryColorLight),
                              SizedBox(height: 20), // Add bottom padding
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  // Modify _onValidate to include delivery type
  void _onValidate() async {
    if (_selectedDeliveryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(('PaymentScreen.select_delivery_method').tr()),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      if (_selectedDeliveryType == DeliveryType.branch &&
          _selectedBranch == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(('PaymentScreen.select_branch').tr()),
            backgroundColor: Colors.red,
          ),
        );
        return;
      } else if (_selectedDeliveryType == DeliveryType.shipping &&
          _selectedAddress == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(('PaymentScreen.select_adress').tr()),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    loading = true;
    setState(() {});
    if (formKey.currentState?.validate() == false) {
      loadingWidget = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ("PaymentScreen.payment_failed").tr(),
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MateButon(
                  title: "Anasayfaya Dön",
                  minimumSize: Size.fromRadius(20),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenBridge(selectedScreen: 0)),
                        (dfas) => true);
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ],
      );
      log("Lütfen kart bilgilerinizi eksiksiz ve doğru şekilde girin.");
    } else {
      // Add delivery type to your payment processing
      int deliveryMethod = _selectedDeliveryType == DeliveryType.branch ? 0 : 1;
      int selectedadres = _selectedAddress?.ID ?? 0;
      int selectedbranch = _selectedBranch?.ID ?? 0;
      // Include delivery method in your API call
      String htmlsTR = await completeCart(cardHolderName, cardNumber,
          expiryDate, cvvCode, deliveryMethod, selectedadres, selectedbranch);

      await wbController.loadHtmlString(htmlsTR);

      setState(() {});

      loadingWidget = Column(
        children: [
          Container(
            width: 200.w,
            height: 100.h,
            child: Text(
              htmlsTR,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MateButon(
                  title: "Anasayfaya Dön",
                  minimumSize: Size.fromRadius(20),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ScreenBridge(selectedScreen: 0)),
                        (dfas) => true);
                  },
                  color: Theme.of(context).primaryColor,
                  textcolor: Theme.of(context).primaryColorLight)
            ],
          ),
        ],
      );
      setState(() {});

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const CuzdanimScreen()),
      //     (route) => false);
    }
  }

  Glassmorphism? _getGlassmorphismConfig() {
    if (!useGlassMorphism) {
      return null;
    }

    final LinearGradient gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[Colors.grey.withAlpha(50), Colors.grey.withAlpha(50)],
      stops: const <double>[0.3, 0],
    );

    return isLightTheme
        ? Glassmorphism(blurX: 8.0, blurY: 16.0, gradient: gradient)
        : Glassmorphism.defaultConfig();
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
