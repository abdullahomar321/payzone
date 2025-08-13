import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SendMoney extends StatefulWidget {
  const SendMoney({super.key});

  @override
  State<SendMoney> createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fundController = TextEditingController();
  bool isLoading=false;


  Future<void> sendMoney(double amount) async {
    final firestore = FirebaseFirestore.instance;

    setState(() => isLoading = true);

    try {
      final senderRef = firestore.collection('Users').doc('accountinfo');
      final recipientRef = firestore.collection('Users').doc('recipients');

      await firestore.runTransaction((transaction) async {
        final senderSnap = await transaction.get(senderRef);
        final recipientSnap = await transaction.get(recipientRef);

        if (!senderSnap.exists || !recipientSnap.exists) {
          throw Exception('Sender or recipient not found');
        }

        final senderBalance =
            double.tryParse(senderSnap['Balance'].toString()) ?? 0;
        final recipientBalance =
            double.tryParse(recipientSnap['balance'].toString()) ?? 0;

        if (senderBalance < amount) {
          throw Exception('Insufficient funds');
        }

        transaction.update(senderRef, {
          'Balance': senderBalance - amount,
        });

        transaction.update(recipientRef, {
          'balance': recipientBalance + amount,
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Funds sent successfully',style: TextStyle(fontSize: 22),)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e',style: TextStyle(fontSize: 22))),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.pinkAccent,
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
                  Icons.arrow_back_ios,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            expandedHeight: 60,
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Send Money',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Jost',
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 60)),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Phone number input
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 90,
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
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
                      ),
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(fontSize: 33),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 90,
                    child: TextField(
                      controller: fundController,
                      decoration: InputDecoration(
                        hintText: 'Enter funds',
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
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 33),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
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
                      onPressed: isLoading
                          ? null
                          : () {
                        final amount = double.tryParse(fundController.text.trim()) ?? 0;

                        if (amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter a valid amount',style: TextStyle(fontSize: 22),)),
                          );
                          return;
                        }

                        sendMoney(amount);
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}