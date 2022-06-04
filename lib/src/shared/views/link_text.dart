import 'package:flutter/material.dart';
import 'package:myartist/src/shared/views/clickable.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String linkTitle;
  final String linkAddress;
  final bool underlined;

  LinkText({
    required this.linkTitle,
    required this.linkAddress,
    this.underlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Clickable(
      child: Text(
        linkTitle,
        style: TextStyle(
          color: Colors.blue.shade400,
          decoration:
              underlined ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
      onTap: () => launchUrl(Uri.parse(linkAddress)),
    );
  }
}
