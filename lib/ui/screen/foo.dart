import 'package:flutter/material.dart';

/// Экран - заглушка.
class Foo extends StatelessWidget {
  const Foo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заглушка'),
      ),
    );
  }
}
