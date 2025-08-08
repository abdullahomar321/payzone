import 'package:flutter/material.dart';
import 'package:payzone/accounts.dart';
import 'package:payzone/dashboard.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController=TextEditingController();
    final TextEditingController pwController=TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.purple,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 70,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>accounts()));
                }, icon: Icon(Icons.arrow_back_ios_new_sharp,size: 30,color: Colors.black,)),
              ),
              backgroundColor: Colors.purple,
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.login_outlined,size: 90,color: Colors.black,),
                    backgroundColor: Colors.pink.shade100,
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
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.pinkAccent,
                            ),
                          ]
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('Login',style: TextStyle(fontFamily: 'Jost',fontWeight: FontWeight.bold,fontSize: 80),),
                            ),
                            Padding(padding:const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
                      child: Container(
                        height: 90,
                        child: TextField(
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          ),
                          controller: usernameController,
                          decoration: InputDecoration(
                            hintText:'Enter Username',
                            hintStyle: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Jost'
                            ),
                            filled: true,
                            fillColor: Colors.purple.shade300,
                            suffixIcon: Icon(Icons.perm_identity_sharp,color: Colors.black,size: 30,),
                            contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 2.1,
                                  color: Colors.black,
                                )
                            ),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                            Padding(padding:const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
                              child: Container(
                                height: 90,
                                child: TextField(
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                  controller: pwController,
                                  decoration: InputDecoration(
                                    hintText:'Enter password',
                                    hintStyle: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Jost'
                                    ),
                                    filled: true,
                                    fillColor: Colors.purple.shade300,
                                    suffixIcon: Icon(Icons.email_outlined,color: Colors.black,size: 30,),
                                    contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          width: 2.1,
                                          color: Colors.black,
                                        )
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
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pushReplacement(context, 
                                      MaterialPageRoute(builder: (context)=>dash()));
                                },
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
      ),
    );
  }
}
