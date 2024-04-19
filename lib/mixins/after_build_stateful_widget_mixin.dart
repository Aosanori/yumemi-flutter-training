import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin AfterBuildStatefulWidgetMixin<T extends StatefulWidget> on State<T> {
  Future<void> _redirectToWeatherPageWithWaitingTime(String url) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await context.push(url);
    }
    await _redirectToWeatherPageWithWaitingTime(url);
  }

  Future<void> redirectTo(String url) async {
    await WidgetsBinding.instance.endOfFrame.then(
      (_) {
        _redirectToWeatherPageWithWaitingTime(url);
      },
    );
  }
}
