import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class viewfav extends StatefulWidget {
  const viewfav({super.key});

  @override
  State<viewfav> createState() => _viewfavState();
}

class _viewfavState extends State<viewfav> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String currentuser;
  List<Map<String, dynamic>> favorites = [];

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
        favorites = favList.map((e) => Map<String, dynamic>.from(e)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            backgroundColor: Colors.pinkAccent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => dash()));
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const SliverToBoxAdapter(
            child: Text(
              'Favorites',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 70,
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          favorites.isEmpty
              ? const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'No favorites yet',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Jost',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final contact = favorites[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
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
                          contact['phone'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          contact['name'] ?? '',
                          style: const TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: favorites.length,
            ),
          ),
        ],
      ),
    );
  }
}
