import 'package:flutter/material.dart';

// 画面下部のボタンを共通化したコンポーネント
class ActionButton extends StatelessWidget {
  const ActionButton({
    required String buttonTitle,
    required void Function()? onPressed,
    super.key,
  }) : _onPressed = onPressed, _buttonTitle = buttonTitle;

  final String _buttonTitle;
  final void Function()? _onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          _buttonTitle,
        ),
      ),
    );
  }
}
