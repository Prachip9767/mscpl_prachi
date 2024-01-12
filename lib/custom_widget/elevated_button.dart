import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isEnabled;
  final String title;

  const AppButton({
    Key? key,
    required this.onPressed,
    required this.isEnabled,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), disabledForegroundColor: Colors.grey.withOpacity(0.38), disabledBackgroundColor: Colors.grey.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          title,
          style: TextStyle(color: isEnabled ? Colors.white : Colors.black45),
        ),
      ),
    );
  }
}
