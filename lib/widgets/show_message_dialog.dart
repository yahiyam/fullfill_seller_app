import 'package:flutter/material.dart';

import '../global/colors.dart';
import 'progress_bar.dart';

Future<dynamic> showMessageDialog(
  BuildContext context, {
  required String message,
  bool isLoading = false,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      if (isLoading) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              circularProgress(),
              const SizedBox(height: 10),
              Text('$message, Please wait...'),
            ],
          ),
        );
      } else {
        return AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: elevatedButtonBGC,
              ),
              child: const Center(
                child: Text(
                  'OK',
                  style: TextStyle(color: white),
                ),
              ),
            ),
          ],
        );
      }
    },
  );
}
