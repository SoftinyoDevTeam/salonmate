import 'package:flutter/material.dart';
import 'package:salonmate/widgets/custom/paymentform.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              child: Text(
                "Ödeme Ekranı",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Theme.of(context).colorScheme.outline,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
        ),
        body: PaymentForm());
  }
}
