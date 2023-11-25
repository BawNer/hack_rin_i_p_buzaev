import 'package:centr_invest_app/core/ui/padding.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboardType;

  final void Function(String) onChanged;

  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.formatter,
    this.keyboardType,
    required this.onChanged,
  });

  @override
  State<InputFieldWidget> createState() => _InputFieldWidget();
}

class _InputFieldWidget extends State<InputFieldWidget> {
  bool _showClearIcon = false;

  void _onFieldChanged() {
    String value = widget.controller.text;

    setState(() {
      _showClearIcon = value.isNotEmpty;
    });
    return;
  }

  @override
  void initState() {
    widget.controller.addListener(_onFieldChanged);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: insets(vertical: 5.0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        enableSuggestions: true,
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
          suffixIcon: _showClearIcon
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => {
              widget.controller.clear(),
              widget.onChanged(widget.controller.text)
            },
          )
              : null,
        ),
        inputFormatters: widget.formatter ?? [],
        onChanged: widget.onChanged,
        validator: (v) => v!.isEmpty ? tr('notEmpty'): null,
      ),
    );
  }
}