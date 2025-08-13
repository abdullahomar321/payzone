import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipient {
  String name;
  String phone;

  Recipient({required this.name, required this.phone});
}

class freq extends StatefulWidget {
  const freq({super.key});

  @override
  State<freq> createState() => _freqState();
}

class _freqState extends State<freq> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  List<Recipient> contacts = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String currentuser;

  Set<String> favorites = {};


  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      currentuser = user.uid;
      _loadFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    final doc = await _firestore.collection('Users').doc(currentuser).get();
    if (doc.exists && doc.data() != null) {
      final favList = doc.data()!['fav'] as List<dynamic>? ?? [];
      setState(() {
        favorites = favList
            .map((e) => e['phone'].toString())
            .toSet();
      });
    }
  }

  Future<void> togglefav(Recipient contact) async {
    final docRef = _firestore.collection('Users').doc(currentuser);
    final contactData = {"name": contact.name, "phone": contact.phone};
    bool isFav = favorites.contains(contact.phone);

    if (!isFav) {
      await docRef.set({
        'fav': FieldValue.arrayUnion([contactData])
      }, SetOptions(merge: true));
      favorites.add(contact.phone);
    } else {
      await docRef.update({
        'fav': FieldValue.arrayRemove([contactData])
      });
      favorites.remove(contact.phone);
    }
  }

  void add() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(
          'Add Contact',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Jost',
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter name',
                hintStyle: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Enter phone',
                hintStyle: TextStyle(
                  fontFamily: 'Jost',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(fontSize: 20)),
          ),
          TextButton(
            onPressed: () {
              String name = nameController.text.trim();
              String num = phoneController.text.trim();
              if (name.isNotEmpty && num.isNotEmpty) {
                setState(() {
                  contacts.add(Recipient(name: name, phone: num));
                });
                nameController.clear();
                phoneController.clear();
                Navigator.pop(context);
              }
            },
            child: const Text('Add', style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }

  // Remove contact
  void remove(int index) {
    setState(() {
      contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50,
            backgroundColor: Colors.pinkAccent,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const dash()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: add,
                  icon: const Icon(Icons.add, size: 35, color: Colors.black),
                ),
              )
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverToBoxAdapter(
            child: Text(
              'Frequent Recipients',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 40,
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final contact = contacts[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onLongPress: () => remove(index),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.pink.shade500,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            contact.phone,
                            style: const TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            contact.name,
                            style: const TextStyle(
                              fontFamily: 'Jost',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await togglefav(contact);
                              setState(() {}); // update star
                            },
                            icon: Icon(
                              favorites.contains(contact.phone)
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: contacts.length,
            ),
          ),
        ],
      ),
    );
  }
}
