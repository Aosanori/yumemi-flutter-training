import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.buttonTitle,
    required this.onPressed,
    super.key,
  });

  final String buttonTitle;
  final void Function()? onPressed;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('buttonTitle', buttonTitle));
    properties
        .add(ObjectFlagProperty<void Function()?>.has('onPressed', onPressed));
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          buttonTitle,
        ),
      ),
    );
  }
}
