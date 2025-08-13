import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';

class security extends StatefulWidget {
  const security({super.key});

  @override
  State<security> createState() => _securityState();
}

class _securityState extends State<security> {
  String username = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('logininfo')
        .get();

    if (doc.exists) {
      setState(() {
        username = doc['username'] ?? '';
        password = doc['password'] ?? '';
      });
    }
  }


  Future<void> _updateField(String fieldname, String newvalue) async{
    await FirebaseFirestore.instance.collection('Users').doc('logininfo').update({fieldname:newvalue});

    setState(() {
      if(fieldname=='username'){
        username=newvalue;
      }else if(fieldname=='password'){
            password=newvalue;
      }
    });
  }

  Future<void> _showChangeDialogue(String fieldname) async{

    final TextEditingController controller=TextEditingController(text: fieldname=='username' ? username:password);

    await showDialog(context: context,
        builder: (context){
      return AlertDialog(
        title: Text('Change ${fieldname[0].toUpperCase()}${fieldname.substring(1)}',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),
        content: TextField(
          controller: controller,
          obscureText: fieldname == 'password',
          decoration: InputDecoration(hintText: 'Enter new $fieldname'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Colors.pinkAccent,fontSize: 22,fontWeight: FontWeight.bold)),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent),
            child: Text('Update',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            onPressed: () async {
              final newValue = controller.text.trim();
              if (newValue.isNotEmpty) {
                await _updateField(fieldname, newValue);
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 210,
            pinned: true,
            backgroundColor: Colors.pinkAccent,
            leading: Padding(
              padding: const EdgeInsets.all(9.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => dash()));
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Center(
                    child: Icon(
                      Icons.shield_outlined,
                      size: 200,
                      color: Colors.black,
                    )),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Security",
                  style: TextStyle(
                    fontSize: 80,
                    fontFamily: 'Jost',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Container(
                height: 200,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.pinkAccent.shade200,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Card(
                  color: Colors.pink.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: $username',
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Password: $password',
                          style: TextStyle(
                            fontFamily: 'Jost',
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 40)),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () =>_showChangeDialogue('password'),
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        backgroundColor:
                        Colors.pink.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Change password",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () => _showChangeDialogue('username'),
                      style: ElevatedButton.styleFrom(
                        elevation: 6,
                        backgroundColor: Colors.pink.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Change Username",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
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
