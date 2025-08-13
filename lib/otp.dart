import 'package:flutter/material.dart';
import 'package:payzone/logo.dart';
import 'package:payzone/signup.dart';
import 'package:payzone/success.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String verificationId = "";
  bool isOTPSent = false;

  Future<void> sendOTP() async {
    String phone = phonenumberController.text.trim();
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number first")),
      );
      return;
    }

    String formattedPhone = phone.startsWith("+92")
        ? phone
        : "+92${phone.substring(1)}";

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: formattedPhone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const success()),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "Verification failed")),
        );
      },
      codeSent: (String verId, int? resendToken) {
        setState(() {
          verificationId = verId;
          isOTPSent = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Sent!")),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  Future<void> verifyOTP() async {
    String phone = phonenumberController.text.trim();
    String otp = otpController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your phone number first")),
      );
      return;
    }
    if (otp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter the OTP")),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const success()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pink.shade300,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: Colors.purple,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const signin()),
                    );
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_sharp,
                      size: 30, color: Colors.black),
                ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const logo()),
                      );
                    },
                    icon: const Icon(Icons.home_filled,
                        size: 30, color: Colors.black),
                  ),
                )
              ],
              pinned: true,
              flexibleSpace: const FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  'Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                      fontFamily: 'Jost'),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: phonenumberController,
                      style: const TextStyle(fontSize: 30, fontFamily: 'Jost'),
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number (e.g. 03343676098)',
                        hintStyle: const TextStyle(fontSize: 25, fontFamily: 'Jost'),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(width: 2.2, color: Colors.black),
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade300,
                        suffixIcon: const Icon(Icons.phone, size: 30, color: Colors.black),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade500,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: sendOTP,
                    child: const Text(
                      'Send OTP',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  if (isOTPSent) ...[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextField(
                        controller: otpController,
                        style: const TextStyle(fontSize: 30, fontFamily: 'Jost'),
                        decoration: InputDecoration(
                          hintText: 'Enter Phone OTP',
                          hintStyle: const TextStyle(fontSize: 25, fontFamily: 'Jost'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                width: 2.2, color: Colors.black),
                          ),
                          filled: true,
                          fillColor: Colors.purple.shade300,
                          suffixIcon: const Icon(Icons.verified_user_rounded,
                              size: 30, color: Colors.black),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade500,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: verifyOTP,
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Jost',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
