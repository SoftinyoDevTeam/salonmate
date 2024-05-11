import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class CanliDestekScreen extends StatefulWidget {
  const CanliDestekScreen({super.key});

  @override
  State<CanliDestekScreen> createState() => _CanliDestekScreenState();
}

class _CanliDestekScreenState extends State<CanliDestekScreen> {
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewX(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight - 100.h,
          javascriptMode: JavascriptMode.unrestricted,
          initialContent: "https://salonmate.co/sabitlive.php",
          initialSourceType: SourceType.url,
          onWebViewCreated: (controller) => webviewController = controller,
        ),
      ),
    );
    ;
  }
}
