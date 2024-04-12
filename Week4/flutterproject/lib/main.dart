// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Coupon(
          width: 224,
          height: 100,
          radius: 8,
          left: "in",
          right: "out",
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 35)),
        Coupon(
          width: 214,
          height: 100,
          radius: 8,
          left: "in",
          right: "in",
        ),
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 35)),
        Coupon(
          width: 214,
          height: 100,
          radius: 8,
          left: "out",
          right: "out",
        ),
      ]),
    ));
  }
}

class Coupon extends StatelessWidget {
  Coupon({
    super.key,
    this.width = 280,
    this.height = 90,
    this.radius,
    this.left,
    this.right,
  });

  double width;
  double height;
  double? radius = 8;
  String? left;
  String? right;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: CouponPaint(
          leftSideColor: Colors.black,
          radius: 10,
          rightSideColor: Colors.black,
          left: left,
          right: right,
        ),
      ),
    );
  }
}

class CouponPaint extends CustomPainter {
  const CouponPaint(
      {required this.radius,
      required this.leftSideColor,
      required this.rightSideColor,
      required this.left,
      required this.right});

  final double radius;
  final Color leftSideColor;
  final Color rightSideColor;
  final String? left;
  final String? right;
  @override
  void paint(Canvas canvas, Size size) {
    Paint leftPaint = Paint()
      ..color = leftSideColor
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    Paint rightPaint = Paint()
      ..color = rightSideColor
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;
    if (left == "in") {
      canvas.drawPath(getLeftPathIn(size.width, size.height), leftPaint);
    } else {
      canvas.drawPath(getLeftPathOut(size.width, size.height), leftPaint);
    }
    if (right == "in") {
      canvas.drawPath(getRightPathIn(size.width, size.height), rightPaint);
    } else {
      canvas.drawPath(getRightPathOut(size.width, size.height), rightPaint);
    }
  }

  Path getLeftPathOut(double x, double y) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, y)
      ..lineTo(y, y)
      ..lineTo(y, 0)
      ..moveTo(0, 0)
      ..arcToPoint(Offset(radius, y),
          radius: Radius.circular(y / 6), clockwise: false)
      ..arcToPoint(Offset(0, y),
          radius: Radius.circular(y / 6), clockwise: false);
    return path;
  }

  Path getLeftPathIn(double x, double y) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, y)
      ..lineTo(y, y)
      ..lineTo(y, 0)
      ..moveTo(0, 0)
      ..arcToPoint(Offset(radius, y),
          radius: Radius.circular(y / 6), clockwise: true)
      ..arcToPoint(Offset(0, y),
          radius: Radius.circular(y / 6), clockwise: true);
    return path;
  }

  Path getRightPathOut(double x, double y) {
    Path path = Path()
      ..moveTo(y, 0)
      ..lineTo(x, 0)
      ..lineTo(x, y)
      ..lineTo(y, y)
      ..moveTo(x, 0)
      ..arcToPoint(Offset(x - radius, y),
          radius: Radius.circular(y / 6), clockwise: true)
      ..arcToPoint(Offset(x, y),
          radius: Radius.circular(y / 6), clockwise: true);

    return path;
  }

  Path getRightPathIn(double x, double y) {
    Path path = Path()
      ..moveTo(y, 0)
      ..lineTo(x, 0)
      ..lineTo(x, y)
      ..lineTo(y, y)
      ..moveTo(x, 0)
      ..arcToPoint(Offset(x - radius, y),
          radius: Radius.circular(y / 6), clockwise: false)
      ..arcToPoint(Offset(x, y),
          radius: Radius.circular(y / 6), clockwise: false);

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
