import 'package:payzone/accounts.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:payzone/otp.dart';

class signin extends StatefulWidget {
  const signin({super.key});

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController pwController = TextEditingController();

  Future<void> _saveUser() async {
    String username = usernameController.text.trim();
    String pw = pwController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter username", style: TextStyle(fontSize: 22))),
      );
      return;
    }

    if (pw.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Set password", style: TextStyle(fontSize: 22))),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('Users').doc('logininfo').set({
        "username": username,
        "password": pw,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registered', style: TextStyle(fontSize: 22))),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Otp()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error : $e", style: TextStyle(fontSize: 22))),
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
            automaticallyImplyLeading: false,
            backgroundColor: Colors.purple,
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => accounts()),
                );
              },
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.black,
                size: 30,
                weight: 200,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CircleAvatar(
              radius: 75,
              child: Icon(
                Icons.person_2_sharp,
                color: Colors.black,
                size: 110,
              ),
              backgroundColor: Colors.pink.shade100,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    fontFamily: 'Jost',
                    fontSize: 75,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, bottom: 10.0),
                  child: Container(
                    height: 90,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Username',
                        hintStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jost',
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade300,
                        suffixIcon: Icon(
                          Icons.perm_identity_sharp,
                          color: Colors.black,
                          size: 30,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2.1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 90,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                      ),
                      controller: pwController,
                      decoration: InputDecoration(
                        hintText: 'Enter password',
                        hintStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Jost',
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade300,
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 2.1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  elevation: 10,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed:_saveUser,
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 37.5,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
