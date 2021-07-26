import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviesListView extends StatelessWidget {
  MoviesListView(
      {Key? key, this.title, this.itemCount, this.builder, this.onPres})
      : super(key: key);
  final String? title;
  final int? itemCount;
  final Function()? onPres;
  final Widget Function(BuildContext, int)? builder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.288,
      child: Column(
        children: [
          Align(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                    fontSize: 14.4,
                    letterSpacing: 0.5,
                  ),
                ),
                GestureDetector(
                  onTap: onPres,
                  child: Row(
                    children: [
                      Text(
                        "View more",
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 12.4,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.blue[900],
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: itemCount,
                  itemBuilder: builder!),
            ),
          ),
        ],
      ),
    );
  }
}
