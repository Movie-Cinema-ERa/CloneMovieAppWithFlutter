import 'package:flutter/material.dart';

class MoviesListView extends StatelessWidget {
  MoviesListView({Key? key, this.title, this.itemCount, this.builder})
      : super(key: key);
  final String? title;
  final int? itemCount;
  final Widget Function(BuildContext, int)? builder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
                fontSize: 14.4,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: itemCount,
                itemBuilder: builder!),
          ),
        ],
      ),
    );
  }
}
