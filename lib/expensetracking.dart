import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';

class expenses extends StatefulWidget {
  const expenses({super.key});

  @override
  State<expenses> createState() => _expensesState();
}

class Expense {
  String title;
  double amount;

  Expense({required this.title, required this.amount});
}

class _expensesState extends State<expenses> {
  final TextEditingController amountcontroller = TextEditingController();
  final TextEditingController titlecontroller = TextEditingController();

  List<Expense> expenses = [

  ];

  void add() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Add Expense",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                hintText: 'Add expense name',
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: amountcontroller,
              decoration: InputDecoration(
                hintText: 'Add amount',
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          TextButton(
            onPressed: () {
              String title = titlecontroller.text.trim();
              double? amount =
              double.tryParse(amountcontroller.text.trim());

              if (title.isNotEmpty && amount != null) {
                setState(() {
                  expenses.add(Expense(title: title, amount: amount));
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }


  void edit(int index){
    TextEditingController titlecontroller =
    TextEditingController(text: expenses[index].title);
    TextEditingController amountcontroller =
    TextEditingController(text: expenses[index].amount.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Edit Expense",
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                hintText: 'Add expense name',
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            TextField(
              controller: amountcontroller,
              decoration: InputDecoration(
                hintText: 'Add amount',
                hintStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
          TextButton(
            onPressed: () {
              String title = titlecontroller.text.trim();
              double? amount =
              double.tryParse(amountcontroller.text.trim());

              if (title.isNotEmpty && amount != null) {
                setState(() {
                  expenses[index].title = title;
                  expenses[index].amount = amount;
                });
              }
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );

  }



  void delete(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pinkAccent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 130,
              backgroundColor: Colors.pinkAccent,
              pinned: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => dash()));
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_sharp,
                    size: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.only(
                      left: 9.0, bottom: 1.0, top: 8.0, right: 9.0),
                  child: Text(
                    "Expense Tracker",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 32.5,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                centerTitle: true,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: add,
                    icon: Icon(
                      Icons.add_box,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: expenses
                      .asMap()
                      .entries
                      .map(
                        (entry) => Container(
                      height: 140,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5,

                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 16),
                                child: Text(
                                  entry.value.title,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              IconButton(
                                icon: Icon(Icons.edit,
                                    size: 30, color: Colors.green),
                                onPressed: ()=>edit(entry.key),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 16, top: 16),
                                child: Text(
                                  "PKR ${entry.value.amount}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              IconButton(
                                icon: Icon(Icons.delete,
                                    size: 30, color: Colors.red),
                                onPressed: () => delete(entry.key),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}