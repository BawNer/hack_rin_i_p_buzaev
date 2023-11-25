import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const PasswordFieldWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidget();
}

class _PasswordFieldWidget extends State<PasswordFieldWidget> {
  bool _showInputData = false;

  void _onUpdateFiledVisibility() {
    setState(() {
      _showInputData = !_showInputData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 5.0,
        bottom: 5.0,
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        obscureText: !_showInputData,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).primaryColor
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: widget.label,
          labelStyle: Theme.of(context).textTheme.bodyLarge,
          suffixIcon: IconButton(
            icon:
            Icon(_showInputData ? Icons.visibility_off : Icons.visibility),
            onPressed: () => _onUpdateFiledVisibility(),
          ),
        ),
        validator: (v) =>
        v!.trim().isEmpty ? tr("notEmpty") : null,
      ),
    );
  }
}