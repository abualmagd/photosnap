import 'package:flutter/material.dart';


class Triangle extends CustomClipper<Path> {
@override
Path getClip(Size size) {
  Path path = Path();
  path.moveTo(size.width/2, 0);
  path.lineTo(0, size.height);
  path.lineTo(size.height, size.width);
  path.close();

  return path;
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
