import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key, this.titleTxt, this.icon, this.onTap})
      : super(key: key);
  final String? titleTxt;
  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: -6,
      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
      leading: Icon(
        icon,
        color: Colors.grey[800],
        size: 18,
      ),
      title: Text(
        titleTxt!,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }
}
