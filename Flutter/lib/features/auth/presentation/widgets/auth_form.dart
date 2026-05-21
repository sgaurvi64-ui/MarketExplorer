import 'package:flutter/material.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(children: children);
  }
}
