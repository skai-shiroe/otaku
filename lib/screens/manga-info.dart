import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: animeStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Affichage d'un message de chargement pendant que les données sont récupérées.
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              trailing: Image.network(data['poster']),
              title: Text(data['name']),
              subtitle: Text(data['poster']),
            );
          }).toList(),
        );
      },
    );
  }
}
