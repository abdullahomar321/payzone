import 'package:flutter/material.dart';
import 'package:payzone/accountinfo.dart';
import 'package:payzone/analysis.dart';
import 'package:payzone/expensetracking.dart';
import 'package:payzone/fav.dart';
import 'package:payzone/frequent.dart';
import 'package:payzone/logo.dart';
import 'package:payzone/paybills.dart';
import 'package:payzone/security.dart';
import 'package:payzone/sendmoney.dart';
import 'package:payzone/taxes.dart';

class SliverWithDrawer extends StatelessWidget {
  const SliverWithDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: dash(),
    );
  }
}
class dash extends StatelessWidget {
  const dash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      drawer: Container(
        width: 390,
        child: Drawer(
          child: Container(
            color: Colors.pinkAccent,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.purpleAccent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0,bottom: 8,top: 8),
                        child: Text('Menu',
                          style: TextStyle
                            (fontFamily: 'Jost',
                              fontSize: 33,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person_2_sharp,color: Colors.black,weight: 33,size: 55,),
                          ),
                          SizedBox(width: 18,),
                          Expanded(child: Text('abdullah_omar.5',
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Jost',
                                fontWeight: FontWeight.bold
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>logo()));
                  }, icon: Icon(Icons.home_filled,color: Colors.black,size: 35,weight: 20,)),
                  title: Text('Home',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>tax()));
                  }, icon: Icon(Icons.calculate_sharp,color: Colors.lightGreen,size: 35,weight: 20,)),
                  title: Text('Calculate Income Tax',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>expenses()));
                  }, icon: Icon(Icons.attach_money_sharp,color: Colors.greenAccent,size: 35,weight: 20,)),
                  title: Text('Track Expenses',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>viewfav()));
                  }, icon: Icon(Icons.star,color: Colors.yellow,size: 35,weight: 20,)),
                  title: Text('Favorites',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>accountinfo()));
                  }, icon: Icon(Icons.manage_accounts_rounded,color: Colors.orangeAccent,size: 35,weight: 20,)),
                  title: Text('Account Info',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                ListTile(
                  tileColor: Colors.pinkAccent,
                  leading: IconButton(onPressed: (){
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context)=>security()));
                  }, icon: Icon(Icons.security_outlined,color: Colors.red.shade900,size: 35,weight: 20,)),
                  title: Text('Security',style: TextStyle(fontFamily: 'Jost',fontSize: 30,fontWeight: FontWeight.bold),),
                ),

              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.pinkAccent,
            expandedHeight: 170,
            pinned: true,
            flexibleSpace:FlexibleSpaceBar(
              title: Text("DashBoard",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,fontFamily: 'Jost',fontStyle: FontStyle.italic),),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      color: Colors.pinkAccent,
                    )
                  ],
                  color: Colors.pink.shade200,
                ),
                height: 450,
                width: 300,
                child: Card(
                  elevation: 6,
                  color: Colors.pink.shade500,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: [
                      buildGrid(Icons.send, "Send Money", context,SendMoney()),
                      buildGrid(Icons.track_changes, "Analyze performance", context,analysis()),
                      buildGrid(Icons.payment_rounded, "Pay Bills", context,bills()),
                      buildGrid(Icons.add_box, "Add Frequent Recipients", context,freq()),
                    ],
                  ),

                ),
              ),
            ),
          )
        ],

      ),
    );
  }
}


Widget buildGrid(IconData icon,String label,BuildContext context,Widget destinationScreen){

  return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=>destinationScreen));
      },

      child:Column(
        children: [
          CircleAvatar(
            radius: 40,
            child: Icon(icon,size: 40,color: Colors.purple),
          ),
          SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'Jost',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )
  );

}