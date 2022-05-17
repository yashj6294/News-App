import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType inputType;
  final String labelText;
  IconButton trailingIcon;
  bool? isVisible = false;
  InputField({
    Key? key,
    required this.trailingIcon,
    required this.controller,
    required this.inputType,
    this.isVisible,
    required this.labelText,
    required this.validator,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: inputType,
      cursorColor: Colors.lightBlue,
      maxLines: 1,
      obscureText: isVisible ?? false,
      decoration: InputDecoration(
        suffixIcon: trailingIcon,
        suffixIconColor: Colors.blue,
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.lightBlue,
        ),
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final double width;
  const Button(
      {Key? key, required this.onTap, required this.text, required this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: MaterialButton(
        onPressed: onTap,
        height: 45.0,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}



