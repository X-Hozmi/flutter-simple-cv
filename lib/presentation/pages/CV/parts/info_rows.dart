part of '../cv_page.dart';

Widget buildInfoRow(
    {required IconData icon, required String text, bool? isHovered}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 16),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          decoration: isHovered != null
              ? isHovered
                  ? TextDecoration.underline
                  : TextDecoration.none
              : null,
        ),
      ),
    ],
  );
}
