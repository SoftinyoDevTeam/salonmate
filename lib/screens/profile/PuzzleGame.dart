import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salonmate/core/extensions.dart';
import 'package:salonmate/core/libs/flutter_jigsaw_puzzle/src/jigsaw.dart';
import 'package:salonmate/widgets/buttons.dart';

class PuzzlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final puzzleKey = GlobalKey<JigsawWidgetState>();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Arka plan görseli (puzzle parçaları ile birlikte)
            Container(
                height: 550.h,
                child: JigsawPuzzle(
                  gridSize: 4,
                  image: const AssetImage(
                      'assets/images/backgrounds/ultimatesiksok.jpeg'),
                  onFinished: () {
                    // ignore: avoid_print
                    print('finished!');
                  },
                  snapSensitivity: .10, // Between 0 and 1
                  puzzleKey: puzzleKey,
                  onBlockSuccess: () {
                    // ignore: avoid_print
                    print('block success!');
                  },
                )),
            // Metin içerikleri
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ULTIMATE REPAIR',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: "8c1b14".toColor()),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'saçtaki hasarı 90 saniyede onarır.',
                      style:
                          TextStyle(fontSize: 16.0, color: "8c1b14".toColor()),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Peki sen,\nyukaridaki “puzzle”ı\n90 saniyede\nçözebilir misin?',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: "8c1b14".toColor()),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        // Puzzle çözme başlatma işlevi
                        await puzzleKey.currentState!.generate();
                      },
                      child: Text('PUZZLE\'I ÇÖZMEYE BAŞLA'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: "8c1b14".toColor(), // Örnek bir renk
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        textStyle: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
