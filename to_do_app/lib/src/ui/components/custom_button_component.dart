//Flutter imports:
import 'package:flutter/material.dart';

Widget customButtonComponent(
  BuildContext context,
  String text,
  IconData icon,
  Color color,
  Function onTap,
) {
  return ElevatedButton(
    onPressed: () {
      onTap();
    },
    style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
      backgroundColor: WidgetStatePropertyAll(color),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    ),
  );
}
