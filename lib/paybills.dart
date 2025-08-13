import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:payzone/dashboard.dart';

class bills extends StatefulWidget {
  const bills({super.key});

  @override
  State<bills> createState() => _billsState();
}

class _billsState extends State<bills> {
  final List<String> bills = ['electricity', 'gas', 'internet'];
  String? currentBiller;

  final TextEditingController amountController = TextEditingController();

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
                    context,
                    MaterialPageRoute(builder: (context) => dash()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: Text(
              'PayBills',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 80,
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 70,
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: currentBiller,
                  decoration: InputDecoration(
                    hintText: 'Select Biller',
                    hintStyle: const TextStyle(
                      fontSize: 30,
                      fontFamily: 'Jost',
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 12,
                    ),
                    fillColor: Colors.purple.shade300,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 2.1,
                        color: Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        width: 2.1,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  items: bills.map((biller) {
                    return DropdownMenuItem<String>(
                      value: biller,
                      child: Text(
                        biller,
                        style: const TextStyle(
                          fontFamily: 'Jost',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      currentBiller = value;
                    });
                  },
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  dropdownColor: Colors.purple.shade300,
                ),
              ),
            ),
          ),


          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: amountController,
                decoration: InputDecoration(
                  hintText: 'Enter funds',
                  hintStyle: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Jost',
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                  fillColor: Colors.purple.shade300,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 2.1,
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      width: 2.1,
                      color: Colors.black,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 33),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade200,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 15,
                      ),
                      shape: const StadiumBorder(),
                      elevation: 5,
                    ),
                    onPressed: () async {
                      if (currentBiller == null || amountController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Select a bill and enter amount')),
                        );
                        return;
                      }

                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      final userDoc = FirebaseFirestore.instance.collection('Users').doc('accountinfo');

                      final double enteredAmount = double.tryParse(amountController.text) ?? 0;
                      if (enteredAmount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter a valid amount')),
                        );
                        return;
                      }

                      try {
                        final snapshot = await userDoc.get();
                        if (!snapshot.exists) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User info not found')),
                          );
                          return;
                        }

                        double currentBalance = (snapshot.data()?['Balance'] ?? 0).toDouble();

                        if (enteredAmount > currentBalance) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Insufficient balance')),
                          );
                          return;
                        }


                        await userDoc.update({'Balance': currentBalance - enteredAmount});


                        final billDoc = FirebaseFirestore.instance.collection('Users').doc(currentBiller);
                        await billDoc.set({'amount': enteredAmount}, SetOptions(merge: true));

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$currentBiller bill paid successfully!')),
                        );

                        amountController.clear();
                        setState(() {
                          currentBiller = null;
                        });

                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    },

                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 30,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
                child: Icon(
                  Icons.payments_sharp,
                  color: Colors.green,
                  size: 140,),
            )
          )
        ],
      ),
    );
  }
}
