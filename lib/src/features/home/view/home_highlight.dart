import 'package:flutter/material.dart';

import '../../../shared/views/views.dart';

class HomeHighlight extends StatelessWidget {
  const HomeHighlight({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Clickable(
              child: SizedBox(
                height: 275,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'assets/images/banner.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
