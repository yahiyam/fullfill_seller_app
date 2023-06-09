import 'package:flutter/material.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({
    super.key,
    required this.title,
    this.padding = true,
  });
  final String title;
  final bool? padding;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: padding! ? screen.width * .05 : 0,
        top: padding! ? screen.width * .05 : 0,
      ),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
