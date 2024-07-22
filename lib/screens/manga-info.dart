import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MangaInformation extends StatefulWidget {
  const MangaInformation({super.key});

  @override
  State<MangaInformation> createState() => _MangaInformationState();
}

class _MangaInformationState extends State<MangaInformation> {
  // Utilisation d'un StreamBuilder pour écouter le flux de données en temps réel.
  final Stream<QuerySnapshot> animeStream =
      FirebaseFirestore.instance.collection('Anime').snapshots();

  // fonction pour mettre a jour le nombre de like

  void addLike(String docID, int likes) {
    var newLikes = likes + 1;
    try {
      FirebaseFirestore.instance
          .collection('Anime')
          .doc(docID)
          // ignore: avoid_print
          .update({'likes': newLikes}).then((value) => print('donnee a jour'));
    } catch (e) {
      print(e.toString());
    }
  }

  // fonction pour supprimer un document specifique

  void deleteManga(String docID) {
    try {
      FirebaseFirestore.instance
          .collection('Anime')
          .doc(docID)
          .delete()
          // ignore: avoid_print
          .then((value) => print('Document supprimé'));
    } catch (e) {
      print('Erreur lors de la suppression du document : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: animeStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Affichage d'un message de chargement pendant que les données sont récupérées.
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> manga =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Image.network(
                      manga['poster'],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          manga['name'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const Text('Annee de production'),
                        Text(
                          manga['year'].toString(),
                          style: const TextStyle(fontSize: 16),
                        ),
                        Row(
                          children: [
                            for (final categorie in manga['categories'])
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: Chip(
                                  backgroundColor:
                                      Color.fromARGB(103, 37, 113, 175),
                                  label: Text(categorie),
                                ),
                              )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.favorite),
                              iconSize: 20,
                              onPressed: () {
                                addLike(document.id, manga['likes']);
                              },
                            ),
                            Text(manga['likes'].toString()),
                            IconButton(
                              padding: const EdgeInsets.only(left: 50),
                              constraints: const BoxConstraints(),
                              icon: const Icon(Icons.delete_outline),
                              iconSize: 20,
                              onPressed: () {
                                deleteManga(document.id);
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
