import 'package:flutter/material.dart';

class TicketShapeBorder extends OutlinedBorder {
  final double sideWidth;
  final double radius;

  TicketShapeBorder({this.sideWidth = 1.0, this.radius = 8.0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(sideWidth);

  @override
  ShapeBorder? scale(double t) {
    return TicketShapeBorder(
      sideWidth: sideWidth * t,
      radius: radius * t,
    );
  }

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return getOuterPath(rect, textDirection: textDirection)!;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..moveTo(rect.left + radius, rect.top)
      ..lineTo(rect.right - radius, rect.top)
      ..arcToPoint(Offset(rect.right, rect.top + radius), radius: Radius.circular(radius))
      ..lineTo(rect.right, rect.bottom - radius)
      ..arcToPoint(Offset(rect.right - radius, rect.bottom), radius: Radius.circular(radius))
      ..lineTo(rect.left + radius, rect.bottom)
      ..arcToPoint(Offset(rect.left, rect.bottom - radius), radius: Radius.circular(radius))
      ..lineTo(rect.left, rect.top + radius)
      ..arcToPoint(Offset(rect.left + radius, rect.top), radius: Radius.circular(radius))
      ..close();
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TicketShapeBorder) {
      return TicketShapeBorder(
        sideWidth: lerpDouble(a.sideWidth, sideWidth, t)!,
        radius: lerpDouble(a.radius, radius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is TicketShapeBorder) {
      return TicketShapeBorder(
        sideWidth: lerpDouble(sideWidth, b.sideWidth, t)!,
        radius: lerpDouble(radius, b.radius, t)!,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Custom painting logic goes here (if needed).
  }

  @override
  ShapeBorder resolve({TextDirection? direction}) {
    return this;
  }

  @override
  OutlinedBorder copyWith({BorderSide? side}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}




