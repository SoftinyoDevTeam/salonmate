import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/const.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/screens/main/ScreenBridge.dart';
import 'package:salonmate/screens/profile/CuzdanimScreen.dart';
import 'package:salonmate/widgets/buttons.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class PaymentForm extends StatefulWidget {
  const PaymentForm({super.key});

  @override
  State<StatefulWidget> createState() => PaymentFormState();
}

class PaymentFormState extends State<PaymentForm> {
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
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void initstate() {}
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: loading
                ? loadingWidget
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CreditCardWidget(
                        labelValidThru: "",
                        enableFloatingCard: useFloatingAnimation,
                        glassmorphismConfig: _getGlassmorphismConfig(),
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        labelCardHolder: "Ad Soyad",
                        labelExpiredDate: "Ay/Yıl",
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
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
                                inputConfiguration: const InputConfiguration(
                                  cardNumberDecoration: InputDecoration(
                                    labelText: 'Kart Numarası',
                                    hintText: 'XXXX XXXX XXXX XXXX',
                                  ),
                                  expiryDateDecoration: InputDecoration(
                                    labelText: 'SKT',
                                    hintText: 'XX/XX',
                                  ),
                                  cvvCodeDecoration: InputDecoration(
                                    labelText: 'CVV',
                                    hintText: 'XXX',
                                  ),
                                  cardHolderDecoration: InputDecoration(
                                    labelText: 'İsim Soyisim',
                                  ),
                                ),
                                onCreditCardModelChange:
                                    onCreditCardModelChange,
                              ),
                              const SizedBox(height: 20),
                              MateButon(
                                  title: "Ödemeyi Yap",
                                  minimumSize: const Size(400, 50),
                                  onPressed: _onValidate,
                                  color: Theme.of(context).primaryColor,
                                  textcolor:
                                      Theme.of(context).primaryColorLight)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  void _onValidate() async {
    loading = true;
    setState(() {});
    if (formKey.currentState?.validate() == false) {
      loadingWidget = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Lütfen kart bilgilerinizi eksiksiz ve doğru şekilde girin.",
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
      String htmlsTR =
          await completeCart(cardHolderName, cardNumber, expiryDate, cvvCode);

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
