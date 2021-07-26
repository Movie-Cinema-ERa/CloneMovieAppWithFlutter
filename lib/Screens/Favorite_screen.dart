import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 1.2,
        title: Text(
          "Favorites",
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: Colors.blue.shade900),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                height: 220,
                width: 220,
                image: AssetImage("assets/images/favourite_icon.png"),
              ),
              SizedBox(
                height: 12,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "To keep the track of any movies you want,",
                    style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    children: [
                      TextSpan(
                        text: "\njust tap the favorite icon",
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
