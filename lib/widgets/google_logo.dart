import 'dart:math';

import 'package:flutter/material.dart';

/// sehingga tidak membutuhkan file gambar.
class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key, this.size = 20});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: const CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  const _GoogleLogoPainter();

  static const Color _blue = Color(0xFF4285F4);
  static const Color _red = Color(0xFFEA4335);
  static const Color _yellow = Color(0xFFFBBC05);
  static const Color _green = Color(0xFF34A853);

  double _rad(double degree) => degree * pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.22;
    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final arcRect = Rect.fromCircle(center: center, radius: radius);

    void arc(Color color, double startDeg, double sweepDeg) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;
      canvas.drawArc(arcRect, _rad(startDeg), _rad(sweepDeg), false, paint);
    }

    // Urutan sudut searah jarum jam dari posisi jam 3.
    arc(_red, 215, 100); // atas
    arc(_yellow, 145, 70); // kiri
    arc(_green, 45, 100); // bawah
    arc(_blue, 0, 45); // kanan bawah

    // Garis horizontal biru pada huruf G.
    final bar = Rect.fromLTRB(
      center.dx,
      center.dy - strokeWidth / 2,
      center.dx + radius + strokeWidth / 2,
      center.dy + strokeWidth / 2,
    );
    canvas.drawRect(bar, Paint()..color = _blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}