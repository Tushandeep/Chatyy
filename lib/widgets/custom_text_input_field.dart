import 'package:flutter/material.dart';

class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.enabled = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool enabled;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<CustomTextInputField> createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  late ThemeData _theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(
        color: _theme.colorScheme.primary,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(1000),
    );

    final OutlineInputBorder enabledBorder = border;

    final OutlineInputBorder focusedBorder = border.copyWith(
      borderSide: border.borderSide.copyWith(
        width: 2,
      ),
    );

    final TextStyle style = TextStyle(
      color: _theme.colorScheme.primary,
    );

    final InputDecoration decoration = InputDecoration(
      labelText: widget.labelText,
      hintText: widget.hintText ?? widget.labelText,
      labelStyle: style,
      hintStyle: style,
      isCollapsed: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 20,
      ),
      prefixIcon: widget.prefixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: widget.prefixIcon,
            )
          : null,
      suffixIcon: widget.suffixIcon != null
          ? Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: widget.suffixIcon,
            )
          : null,
      enabled: widget.enabled,
      border: border,
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
    );

    return TextFormField(
      controller: widget.controller,
      style: style,
      obscureText: widget.obscureText,
      decoration: decoration,
    );
  }
}
