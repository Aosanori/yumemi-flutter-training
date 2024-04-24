import 'package:flutter/material.dart';

class TemperatureDisplay extends StatelessWidget {
  const TemperatureDisplay({
    required int? temperature,
    required Color textColor,
    super.key,
  })  : _textColor = textColor,
        _temperature = temperature;
  final int? _temperature;
  final Color _textColor;

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.labelLarge!.copyWith(color: _textColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        '${_temperature ??  '**'} ℃',
        style: textStyle,
      ),
    );
  }
}
