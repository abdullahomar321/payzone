import 'package:flutter/material.dart';
import 'package:payzone/logo.dart';
import 'package:payzone/signup.dart';
import 'package:payzone/success.dart';

class otp extends StatelessWidget {
  const otp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phonenumberController=TextEditingController();
    final TextEditingController otpController=TextEditingController();



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
                child: IconButton(onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>signin()));
                }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: 30,color: Colors.black,)),
              ),
              automaticallyImplyLeading: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>logo()));
                  }, icon: Icon(Icons.home_filled,size: 30,color: Colors.black,)),
                )
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('Verification',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black,fontFamily: 'Jost'),),
              ),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: phonenumberController,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Jost',
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number',
                        hintStyle: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Jost',
                        ),
                      contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 2.2,
                          color: Colors.black
                        )
                      ),

                      filled: true,
                        fillColor: Colors.purple.shade300,
                        suffixIcon: Icon(Icons.phone,size: 30,color: Colors.black,)
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade500,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: (){

                    },
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
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: phonenumberController,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Jost',
                      ),
                      decoration: InputDecoration(
                          hintText: 'Enter Phone OTP',
                          hintStyle: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Jost',
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  width: 2.2,
                                  color: Colors.black
                              )
                          ),

                          filled: true,
                          fillColor: Colors.purple.shade300,
                          suffixIcon: Icon(Icons.verified_user_rounded,size: 30,color: Colors.black,)
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 15,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink.shade500,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>success()));
                    },
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
                ],
              )
            ),

          ],
        ),
      ),
    );
  }
}
