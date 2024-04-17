import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
  });
  
  final String buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonTitle,
        ),
      ),
    );
  }
}
