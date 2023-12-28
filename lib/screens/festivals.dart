// ignore_for_file: camel_case_types, prefer_const_constructors
import 'dart:io';
import 'dart:ui';
import 'package:festival_app/screens/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

class Festivals_app extends StatefulWidget {
  const Festivals_app({super.key});

  @override
  State<Festivals_app> createState() => _Festivals_appState();
}

class _Festivals_appState extends State<Festivals_app> {
  Color chooseColor = Colors.black;
  String chooseFonts = '';
  Color chooseBackGroundColor = Colors.white;
  String chooseImage = '';
  double fontSize = 25;

  TextEditingController festQuoteController = TextEditingController();
  GlobalKey repaintBoundry = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? Data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    void shareImage() async {
      RenderRepaintBoundary renderRepaintBoundary =
          repaintBoundry.currentContext!.findRenderObject()
              as RenderRepaintBoundary;

      var image = await renderRepaintBoundary.toImage(pixelRatio: 5);

      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

      Uint8List fetchImage = byteData!.buffer.asUint8List();

      Directory directory = await getApplicationCacheDirectory();

      String path = directory.path;

      File file = File('$path.png');

      file.writeAsBytes(fetchImage);

      ShareExtend.share(file.path, "Image");
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${Data['festival']} Post Design',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              shareImage();
            },
            icon: const Icon(Icons.share),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  chooseColor = Colors.black;
                  chooseBackGroundColor = Colors.white;
                  chooseImage = '';
                  chooseFonts = '';
                  Festivals.fest_quote = 'To Add + Quote';
                });
              },
              icon: const Icon(Icons.restart_alt)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Add Quote',
                ),
                content: TextField(
                  controller: festQuoteController,
                  decoration: InputDecoration(
                    hintText: 'Enter Quote',
                  ),
                ),
                actions: [
                  OutlinedButton(
                    onPressed: () {
                      Festivals.fest_quote = festQuoteController.text;
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text('Done'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            RepaintBoundary(
              key: repaintBoundry,
              child: Card(
                elevation: 8,
                child: Container(
                  padding: const EdgeInsets.all(25),
                  width: double.infinity,
                  height: 330,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: chooseBackGroundColor,
                    image: DecorationImage(
                      image: AssetImage('assets/img/$chooseImage'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Text(
                    Festivals.fest_quote,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: chooseColor,
                      fontFamily: chooseFonts,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Fonts",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: Festivals.fonts.map(
                          (e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chooseFonts = e;
                                });
                              },
                              child: Container(
                                height: 35,
                                width: 60,
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: FractionalOffset.center,
                                child: Text(
                                  'abc',
                                  style: TextStyle(fontSize: 22, fontFamily: e),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8),
              child: const Text(
                "Background Image",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: (Data['images'] as List<String>).map(
                          (e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chooseImage = e;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: AssetImage('assets/img/$e'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Color",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: Colors.primaries.map(
                          (e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chooseColor = e;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: e,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Background Color",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black45,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: Colors.accents.map(
                          (e) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  chooseImage = '';
                                  chooseBackGroundColor = e;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: e,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            // Label Fonts
          ],
        ),
      ),
    );
  }
}
