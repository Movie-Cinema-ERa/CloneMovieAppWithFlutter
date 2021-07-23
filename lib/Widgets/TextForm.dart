import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextForm extends StatelessWidget {
  CustomTextForm(
      {Key? key,
      this.label,
      this.hint,
      this.preIcon,
      this.txtType,
      this.editTxtControl,
      this.obscureText = false})
      : super(key: key);
  final String? label;
  final String? hint;
  final IconData? preIcon;
  final TextInputType? txtType;
  final TextEditingController? editTxtControl;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.06,
      child: TextFormField(
        controller: editTxtControl,
        style: TextStyle(color: Colors.blue[700], fontSize: 15),
        keyboardType: txtType,
        cursorColor: Colors.blue,
        obscureText: obscureText!,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(fontSize: 15, color: Colors.blue),
            hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
            contentPadding: EdgeInsets.only(top: 0.0),
            isDense: true,
            prefixIcon: Icon(
              preIcon,
              size: 17,
              color: Colors.blue,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
                borderSide:
                    BorderSide(color: Colors.blue.shade700, width: 0.6)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide(color: Colors.blue.shade800, width: 0.6),
            ),
            hintText: hint),
      ),
    );
  }
}
