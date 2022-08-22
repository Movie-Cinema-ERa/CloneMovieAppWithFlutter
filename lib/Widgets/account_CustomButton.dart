import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Color? colors;
  final BorderSide? borderOutline;
  final TextStyle? txtStyle;
  final Function()? onpress;
  CustomButton(
      {Key? key,
      this.label,
      this.colors,
      this.borderOutline,
      this.txtStyle,
      this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: TextButton.styleFrom(
              visualDensity: VisualDensity(horizontal: -1.5),
              backgroundColor: colors,
              side: borderOutline,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
              padding: EdgeInsets.symmetric(horizontal: 20)),
          onPressed: onpress,
          child: Text(label!, style: txtStyle)),
    );
  }
}
