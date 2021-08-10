import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      this.label,
      this.colors,
      this.borderOutline,
      this.txtStyle,
      this.onpress})
      : super(key: key);
  final String? label;
  final Color? colors;
  final BorderSide? borderOutline;
  final TextStyle? txtStyle;
  final Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: TextButton.styleFrom(
            visualDensity: VisualDensity(horizontal: -1.5),
            backgroundColor: colors,
            side: borderOutline,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
            padding: EdgeInsets.symmetric(horizontal: 98)),
        onPressed: onpress,
        child: Text(label!, style: txtStyle));
  }
}
