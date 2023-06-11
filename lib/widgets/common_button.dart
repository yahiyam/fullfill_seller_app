

import 'package:flutter/material.dart';

import '../global/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.title,
    this.isWhite = false,
    this.onTap,
  });

  final String? title;
  final bool isWhite;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: screen.height * 0.08,
      child: Material(
        color: isWhite ? white : commonColor,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          splashColor: black12,
          borderRadius: BorderRadius.circular(30),
          child: Center(
            child: Text(
              title ?? '',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                height: 1,
                color: isWhite ? commonColor : white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
