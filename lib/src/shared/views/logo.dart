import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 12,
      ),
      height: 80,
      child: Row(
        children: [
          Icon(
            Icons.anchor,
            color: Colors.blue.shade800,
            size: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "Nautical",
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
