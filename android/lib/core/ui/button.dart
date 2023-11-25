import 'package:flutter/material.dart';

class ButtonPrimary extends StatefulWidget {
  final Widget label;

  final VoidCallback onPressed;

  const ButtonPrimary({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  State<ButtonPrimary> createState() => _ButtonPrimary();
}

class _ButtonPrimary extends State<ButtonPrimary> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: widget.onPressed,
      child: widget.label,
    );
  }
}