import 'dart:math';

import 'package:flutter/material.dart';

import '../core/app_colors.dart';

/// Menggambar pola mirip QR (dummy) menggunakan CustomPainter.
class QrisPainter extends CustomPainter {
  const QrisPainter({required this.seed});

  final int seed;
  static const int _cells = 25;

  bool _isFinderZone(int row, int col) =>
      (row < 8 && col < 8) ||
      (row < 8 && col >= _cells - 8) ||
      (row >= _cells - 8 && col < 8);

  @override
  void paint(Canvas canvas, Size size) {
    final cell = size.width / _cells;
    final dark = Paint()..color = AppColors.dark;
    final light = Paint()..color = Colors.white;
    final random = Random(seed);

    for (var r = 0; r < _cells; r++) {
      for (var c = 0; c < _cells; c++) {
        if (_isFinderZone(r, c)) continue;
        if (random.nextBool()) {
          canvas.drawRect(Rect.fromLTWH(c * cell, r * cell, cell, cell), dark);
        }
      }
    }

    void finder(int row, int col) {
      Rect rect(int offset, int length) => Rect.fromLTWH(
          (col + offset) * cell, (row + offset) * cell, length * cell, length * cell);
      canvas.drawRect(rect(0, 7), dark);
      canvas.drawRect(rect(1, 5), light);
      canvas.drawRect(rect(2, 3), dark);
    }

    finder(0, 0);
    finder(0, _cells - 7);
    finder(_cells - 7, 0);
  }

  @override
  bool shouldRepaint(QrisPainter old) => old.seed != seed;
}
