import 'package:flutter/material.dart';

class CircularCheckbox extends StatelessWidget {
  final bool isChecked;
  final Function(bool?) onChanged;

  const CircularCheckbox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!isChecked),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          border: Border.all(
            color: isChecked ? Colors.blue : Colors.grey,
            width: isChecked ? 2 : 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: isChecked
              ? const Icon(
            Icons.check_circle,
            size: 16.0,
            color: Colors.white,
          )
              : const Icon(
            Icons.radio_button_unchecked,
            size: 16.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

