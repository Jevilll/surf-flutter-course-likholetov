import 'package:flutter/material.dart';

/// Экран списка достопримечательностей.
class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  State<SightListScreen> createState() => _SightListScreenState();
}

class _SightListScreenState extends State<SightListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Color(0xFF252849),
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(text: 'С', style: TextStyle(color: Colors.green),),
              TextSpan(text: 'писок\n'),
              TextSpan(text: 'и', style: TextStyle(color: Colors.yellow),),
              TextSpan(text: 'нтересных мест'),
            ],
          ),
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
      ),
    );
  }
}
