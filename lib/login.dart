import 'package:flutter/material.dart';
import 'package:payzone/accounts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payzone/dashboard.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> loginUser() async {
    String username = usernameController.text.trim();
    String password = pwController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Enter both fields',
            style: TextStyle(fontSize: 22),
          ),
        ),
      );
      return;
    }
    try {
      DocumentSnapshot doc =
      await firestore.collection('Users').doc('logininfo').get();

      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Data not found',
              style: TextStyle(fontSize: 22),
            ),
          ),
        );
        return;
      }

      String dbuser = doc['username'];
      String dbpw = doc['password'];

      if (dbuser == username && dbpw == password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Login Successful",
              style: TextStyle(fontSize: 22),
            ),
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const dash()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Invalid Credentials!!",
              style: TextStyle(fontSize: 22),
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
            style: TextStyle(fontSize: 22),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const accounts()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.purple,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 15),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.pink.shade100,
                  child: const Icon(
                    Icons.login_outlined,
                    size: 90,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    elevation: 9,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    color: Colors.pink.shade300,
                    child: Container(
                      height: 550,
                      width: 550,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.pinkAccent,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 80,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: SizedBox(
                              height: 90,
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                                controller: usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Username',
                                  hintStyle: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Jost',
                                  ),
                                  filled: true,
                                  fillColor: Colors.purple.shade300,
                                  suffixIcon: const Icon(
                                    Icons.perm_identity_sharp,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      width: 2.1,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10.0,
                              right: 10.0,
                              bottom: 10.0,
                            ),
                            child: SizedBox(
                              height: 90,
                              child: TextField(
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                ),
                                controller: pwController,
                                decoration: InputDecoration(
                                  hintText: 'Enter password',
                                  hintStyle: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Jost',
                                  ),
                                  filled: true,
                                  fillColor: Colors.purple.shade300,
                                  suffixIcon: const Icon(
                                    Icons.email_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                      width: 2.1,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink.shade200,
                                elevation: 10,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 15,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: loginUser,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 37.5,
                                  fontFamily: 'Jost',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
