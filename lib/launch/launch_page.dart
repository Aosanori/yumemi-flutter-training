import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/mixins/after_build_stateful_widget_mixin.dart';
import 'package:go_router/go_router.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => LaunchPageState();
}

class LaunchPageState extends State<LaunchPage>
    with AfterBuildStatefulWidgetMixin {

  @override
  Future<void> afterFirstBuild() async {
    await _redirectTo('/weather');
  }

  Future<void> _redirectTo(String url) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      await context.push(url);
    }
    await _redirectTo(url);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.green);
  }
}
