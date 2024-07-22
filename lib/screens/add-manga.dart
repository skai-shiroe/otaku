import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();
  final posterController = TextEditingController();
  List<String> categories = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Manga'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.white, width: 1.5)),
                title: Row(
                  children: [
                    const Text('Nom :'),
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        controller: nameController,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.white, width: 1.5)),
                title: Row(
                  children: [
                    const Text('Annee :'),
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        controller: yearController,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.white, width: 1.5)),
                title: Row(
                  children: [
                    const Text('Images :'),
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        controller: posterController,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropDownMultiSelect(
                decoration: const InputDecoration(
                  labelText: 'Catégories',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                onChanged: (List<String> x) {
                  setState(() {
                    categories = x;
                  });
                },
                options: const [
                  'Action',
                  'Psychologique',
                  'Drame',
                  'Ecchi',
                  'Aventure',
                  'Tournois',
                  'Romance',
                  'Combat'
                ],
                selectedValues: categories,
                //whenEmpty: '--',
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size.fromHeight(50),
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  //color: Colors.blue,
                ),
                onPressed: () {
                  FirebaseFirestore.instance.collection('Anime').add({
                    'name': nameController.value.text,
                    'year': yearController.value.text,
                    'poster': posterController.value.text,
                    'categories': categories,
                    'likes': 0,
                  });
                  Navigator.pop(context); // fermeture du formulaire
                },
                child: const Text(
                  'Ajouter',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
