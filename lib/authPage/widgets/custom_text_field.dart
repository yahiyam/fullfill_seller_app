import 'package:flutter/material.dart';

import '../../global/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool? obscureText;
  final String? labelText;
  final IconData? icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? showSuffixIcon;
  const CustomTextField({
    super.key,
    this.obscureText = false,
    this.labelText,
    this.icon,
    this.controller,
    this.keyboardType,
    this.showSuffixIcon = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _passwordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText! && !_passwordVisible,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.icon,
          color: iconColor,
        ),
        suffixIcon: widget.obscureText! && widget.showSuffixIcon!
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: _togglePasswordVisibility,
              )
            : null,
      ),
    );
  }
}
