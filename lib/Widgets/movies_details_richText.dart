import 'package:flutter/material.dart';

class RichTextMovieDetails extends StatelessWidget {
  const RichTextMovieDetails({Key? key, this.header, this.body})
      : super(key: key);
  final String? header;
  final String? body;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: header,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
          fontSize: 11.4,
          letterSpacing: 0.4,
        ),
        children: [
          TextSpan(
            text: body,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 11,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
