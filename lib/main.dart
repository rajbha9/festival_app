import 'package:festival_app/screens/festivals.dart';
import 'package:festival_app/screens/spalesh.dart';
import 'package:festival_app/screens/util.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.deepPurple),
        appBarTheme: const AppBarTheme(color: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: 'spalesh',
      routes: {
        '/': (context) => const HomePage(),
        'spalesh': (context) => const SpaleshScreen(),
        'festival1': (context) => const Festivals_app(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Festivals',
          style: TextStyle(fontSize: 25, letterSpacing: 1),
        ),
      ),
      body: ListView(
        children: Festivals.festival.map(
          (e) {
            return Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(25),
                  // border: Border.all(color: Colors.amber, width: 3),
                ),
                margin: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 90,
                        width: 120,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Image.network(e['img']),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e['festival'],
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed('festival1', arguments: e),
                      icon: const Icon(
                        Icons.chevron_right_sharp,
                        size: 35,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
