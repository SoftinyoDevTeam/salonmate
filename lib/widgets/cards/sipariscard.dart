import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/functions.dart';
import 'package:salonmate/widgets/custom/mateimage.dart';

class SiparisWidget extends StatelessWidget {
  final String? fullName;

  final String? imagePath;
  final String? fiyat;
  final String? status;
  final int? urunSayisi;

  const SiparisWidget({
    required this.fullName,
    required this.imagePath,
    required this.fiyat,
    required this.urunSayisi,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 0,
            blurRadius: 10,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        // Widget'ın içeriği
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50.w,
                  width: 50.w,
                  child: MateImage(imageUrl: imagePath),
                ),
                // Kullanıcı adı ve telefon numarası
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName!.kisalt(25),
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(fiyat!),
                  ],
                ),
              ],
            ),

            // Son alışveriş bilgileri
            Divider(
              thickness: 1,
              color: Theme.of(context).colorScheme.outline,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (status == "0")
                  Text(
                    "Ödeme Onay Bekliyor",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                if (status == "1")
                  Text(
                    "Ödeme Onaylandı, Teslimat Alınmadı",
                    style: TextStyle(
                        color: Colors.yellow, fontWeight: FontWeight.bold),
                  ),
                if (status == "2")
                  Text(
                    "Teslim Edildi",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                Text(
                  "${urunSayisi.toString()} Ürün",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
