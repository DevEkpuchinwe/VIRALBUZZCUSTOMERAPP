import 'package:flutter/material.dart';

class BottomRoundedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.45);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.45);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
