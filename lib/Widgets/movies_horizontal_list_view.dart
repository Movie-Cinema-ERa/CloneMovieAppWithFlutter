import 'package:flutter/material.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({Key? key, this.title, this.moviesName, this.image})
      : super(key: key);
  final String? title;
  final String? moviesName;
  final String? image;

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
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        child: Image.asset(
                          image!,
                          height: 130,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        moviesName.toString(),
                        style: TextStyle(
                          color: Colors.blue[800],
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
