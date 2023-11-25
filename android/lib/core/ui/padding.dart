import 'package:flutter/material.dart';

EdgeInsets insets({
  double? all,
  double? vertical,
  double? horizontal,
  double? top,
  double? left,
  double? right,
  double? bottom
}) {
  if (all != null) return EdgeInsets.all(all);

  if (vertical != null || horizontal != null) {
    return EdgeInsets.symmetric(vertical: vertical ?? 0.0, horizontal: horizontal ?? 0.0);
  }

  return EdgeInsets.only(
      left: left ?? 0.0,
      top: top ?? 0.0,
      right: right ?? 0.0,
      bottom: bottom ?? 0.0
  );
}