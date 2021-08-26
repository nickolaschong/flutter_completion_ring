import 'package:flutter/material.dart';

import 'animated_completion_ring.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Completion Ring',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Completion Ring'),
      ),
      body: const Center(
        child: FractionallySizedBox(
          heightFactor: 0.4,
          child: AnimatedCompletionRing(),
        ),
      ),
    );
  }
}
