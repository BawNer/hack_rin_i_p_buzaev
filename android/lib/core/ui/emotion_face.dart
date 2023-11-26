import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:flutter/material.dart';

class EmoticonFace extends StatelessWidget {
  final String emotion;

  const EmoticonFace({required this.emotion, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white30,
          borderRadius: BorderRadius.circular(12)),
      padding: insets(all: 12),
      child: Center(
        child: Text(
          emotion,
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
