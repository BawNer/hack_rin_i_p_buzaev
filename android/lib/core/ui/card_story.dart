import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:flutter/material.dart';

class CardStory extends StatelessWidget {
  final Color color;
  final Widget child;

  const CardStory({
    required this.child,
    required this.color,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 20,
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: insets(all: 12),
      child: child,
    );
  }
}
