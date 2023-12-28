import 'dart:async';

import 'package:flutter/material.dart';

class SpaleshScreen extends StatefulWidget {
  const SpaleshScreen({super.key});

  @override
  State<SpaleshScreen> createState() => _SpaleshScreenState();
}

class _SpaleshScreenState extends State<SpaleshScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacementNamed('/');
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircleAvatar(backgroundColor: Colors.transparent,
          child: Image.asset('assets/img/thinking.png',color: Colors.orange),
          radius: 80,
        ),
      ),
    );
  }
}
