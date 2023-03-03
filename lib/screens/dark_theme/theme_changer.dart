import 'package:flutter/material.dart';

class ThemeBuilder extends StatefulWidget {
  const ThemeBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, Brightness brightness) builder;

  @override
  State<ThemeBuilder> createState() => _ThemeBuilderState();
}

class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness? _brightness;
  @override
  void initState() {
    super.initState();
    _brightness = Brightness.light;
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness!);
  }
}
