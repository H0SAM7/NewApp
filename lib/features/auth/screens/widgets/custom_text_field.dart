import 'package:flutter/material.dart';
import 'package:my_visitor/constants.dart';

class CustomTextFrom extends StatefulWidget {
  const CustomTextFrom({
    super.key,
    this.onChanged,
    required this.label,
    required this.hint,
    this.hide = false,
    this.validator,
    this.isPasswordField = false,
    this.controller,
    this.enabel = true, this.prefixIcon, this.readOnly,
  });
  final void Function(String)? onChanged;
  final String label, hint;
  final bool hide;
final  bool? readOnly ;
  final bool? enabel;
  final String? Function(String?)? validator;
  final bool isPasswordField;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  @override
  State<CustomTextFrom> createState() => _CustomTextFromState();
}

class _CustomTextFromState extends State<CustomTextFrom> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly:widget.readOnly?? false ,
        controller: widget.controller,
        validator: widget.validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'complete fields';
              }
              return null;
            },
        onChanged: widget.onChanged,
        obscureText: widget.isPasswordField ? _isObscure : false,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          focusColor: Colors.black,
          filled: true,
          fillColor: Colors.white,
          label: Text(
            widget.label,
            style: TextStyle(
                color: redColor, fontSize: 16, fontWeight: FontWeight.bold,),
          ),
          hintText: widget.hint,
          enabled: widget.enabel ?? true,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: redColor),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          prefixIcon:widget.prefixIcon ,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                    color: redColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

final outlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.black),
  borderRadius: const BorderRadius.all(Radius.circular(16)),
);
