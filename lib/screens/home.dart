import 'package:flutter/material.dart';
import 'package:otaku/screens/add-manga.dart';
import 'package:otaku/screens/manga-info.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(197, 1, 44, 61),
      appBar: AppBar(
        title: const Text(
          'Manga Store',
          style: TextStyle(),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                  fullscreenDialog: true,
                ),
              );
            },
            icon: const Icon(Icons.add)),
      ),
      body: MangaInformation(),
    );
  }
}
