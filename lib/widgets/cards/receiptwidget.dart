import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double shippingFee;
  final double serviceFee;
  final double tax;

  const OrderSummaryWidget({
    Key? key,
    required this.subtotal,
    required this.shippingFee,
    required this.serviceFee,
    required this.tax,
  }) : super(key: key);

  double get total => subtotal + shippingFee + serviceFee + tax;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
              ('PaymentScreen.order_summary').tr(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
          _buildPriceRow(
            context,
            ('PaymentScreen.subtotal').tr(),
            subtotal,
          ),
          _buildPriceRow(
            context,
            ('PaymentScreen.shipping_fee').tr(),
            shippingFee,
          ),
          _buildPriceRow(
            context,
            ('PaymentScreen.service_fee').tr(),
            serviceFee,
          ),
          _buildPriceRow(
            context,
            ('PaymentScreen.tax').tr(),
            tax,
          ),
          Divider(height: 1, color: Colors.grey.withOpacity(0.3)),
          Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ('PaymentScreen.total').tr(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '₺${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String label, double amount) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
          Text(
            '₺${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
