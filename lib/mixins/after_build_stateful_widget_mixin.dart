import 'dart:async';
import 'package:flutter/material.dart';

mixin AfterBuildStatefulWidgetMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    unawaited(
      WidgetsBinding.instance.endOfFrame.then(
        (_) {
          if (mounted) {
            afterFirstBuild();
          }
        },
      ),
    );
  }

  void afterFirstBuild() {}
}
