import '../config/app_themes.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onClick,
    this.text,
  }) : super(key: key);
  final String? text;
  final Function() onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: AppThemes.PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(20),
    ),),
      onPressed: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        child: Text(
          text ?? 'Sample Text',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),

      ),
    );
  }
}
