import 'package:flutter/material.dart';
import 'package:fullfill_seller_app/global/colors.dart';

circularProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    child: const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        commonColor,
      ),
    ),
  );
}
linearProgress() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.only(top: 12),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        commonColor,
      ),
    ),
  );
}
