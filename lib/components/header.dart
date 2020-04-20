import 'package:flutter/material.dart';

class Header extends StatelessWidget with PreferredSizeWidget {
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Image.asset('assets/images/logo.png'),
        ],
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment(1, 0.0),
            colors: [const Color(0xFF3827B4), const Color(0xFF6C18A4)],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }

  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
