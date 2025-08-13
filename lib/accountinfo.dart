import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class accountinfo extends StatefulWidget {
  const accountinfo({super.key});

  @override
  State<accountinfo> createState() => _accountinfoState();
}

class _accountinfoState extends State<accountinfo> {
  String accountNum = '';
  String balance = '';
  String phoneNumber = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAccountInfo();
  }

  Future<void> fetchAccountInfo() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc('accountinfo')
          .get();

      print("DEBUG: ${doc.data()}"); // For debugging

      if (doc.exists) {
        setState(() {
          accountNum = doc['accountnum'] ?? '';
          balance = doc['Balance'].toString();
          phoneNumber = doc['phonenumber'] ?? '';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false; // Still stop loading even if no data
        });
      }
    } catch (e) {
      print("Error fetching account info: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget infoContainer(String text) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.purple.shade200,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(9.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Jost',
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: Colors.pinkAccent,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => dash()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.only(bottom: 10),
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.person,
                    size: 75,
                    color: Colors.purpleAccent,
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(9.5),
              child: Text(
                "Account Details",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
          SliverToBoxAdapter(
            child: infoContainer("Account Number: $accountNum"),
          ),
          SliverToBoxAdapter(
            child: infoContainer("Balance: $balance"),
          ),
          SliverToBoxAdapter(
            child: infoContainer("Phone Number: $phoneNumber"),
          ),
        ],
      ),
    );
  }
}
