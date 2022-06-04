import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      height: 80,
      child: Row(
        children: [
          Icon(
            Icons.anchor,
            color: Colors.blue.shade800,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Anchor",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
