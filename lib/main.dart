import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyFirstStatefulWidget(),
    );
  }
}

class MyFirstStatelessWidget extends StatelessWidget {

  MyFirstStatelessWidget({Key? key}) : super(key: key);

  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    print('Вызов build у stateless: ${++_counter}');
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}

class MyFirstStatefulWidget extends StatefulWidget {
  const MyFirstStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyFirstStatefulWidget> createState() => _MyFirstStatefulWidgetState();
}

class _MyFirstStatefulWidgetState extends State<MyFirstStatefulWidget> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    print('Вызов build у statefull: ${++_counter}');
    return Container(
      child: const Center(
        child: Text('Hello!'),
      ),
    );
  }
}
