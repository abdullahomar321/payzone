import 'package:payzone/login.dart';
import 'package:payzone/logo.dart';
import 'package:flutter/material.dart';
import 'package:payzone/signup.dart';

class accounts extends StatelessWidget {
  const accounts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.purple,
              automaticallyImplyLeading: false,
              expandedHeight: 70,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context)=>logo()));
                }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: 30,color: Colors.black,weight: 200,)),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 220,),),
            SliverToBoxAdapter(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell( onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>signin()));
                    },
                      child: Container(
                        margin: EdgeInsets.only(left: 15,right: 15),
                        height: 190,
                        width: 190,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pinkAccent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black,
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("Sign Up",
                            style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell( onTap: (){
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=>login()));
                    },
                      child:Container(
                        margin: EdgeInsets.all(15),
                        height: 190,
                        width: 190,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.pinkAccent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.black,
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("Log In",
                            style: TextStyle(
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

        ),
      ),

    );
  }
}