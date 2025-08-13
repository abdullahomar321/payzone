import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';

class tax extends StatefulWidget {
  const tax({super.key});

  @override
  State<tax> createState() => _taxState();
}

class _taxState extends State<tax> {
  final TextEditingController incomeController = TextEditingController();
  String income = "";
  double taxOwed = 0;

  double calculatetax(String monthlypay) {
    double monthlyincome = double.tryParse(monthlypay) ?? 0;
    double annualIncome = monthlyincome * 12;

    if (annualIncome > 600000) {
      return annualIncome * 0.025;
    } else {
      return 0;
    }
  }

  void addincome() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          "Add Income",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: incomeController,
              decoration: InputDecoration(
                hintText: 'Enter Income',
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
              setState(() {
                income = incomeController.text;
                taxOwed = calculatetax(income);
              });
              Navigator.pop(context);
            },
            child: Text(
              "Save",
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

  @override
  Widget build(BuildContext context) {
    double monthlyIncome = double.tryParse(income) ?? 0;
    double annualIncome = monthlyIncome * 12;

    double federalTax = annualIncome > 600000 ? annualIncome * 0.02 : 0;
    double provincialTax = annualIncome > 600000 ? annualIncome * 0.005 : 0;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pinkAccent,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              backgroundColor: Colors.pinkAccent,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Tax Calculator",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Jost',
                    fontStyle: FontStyle.italic,
                  ),
                ),
                centerTitle: true,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => dash()),
                  );
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 85),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        blurRadius: 8,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      income.isNotEmpty
                          ? "PKR $income /month"
                          : "No income added",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                  child: ElevatedButton(
                    onPressed: addincome,
                    child: Text(
                      "Add Income",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Colors.purple.shade200,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            // General Tax Container
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        blurRadius: 8,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      income.isNotEmpty
                          ? "Tax Owed: PKR ${taxOwed.toStringAsFixed(2)} /year"
                          : "No tax to display",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            // Federal Tax Container
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        blurRadius: 8,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      income.isNotEmpty
                          ? "Federal Tax: PKR ${federalTax.toStringAsFixed(2)} /year"
                          : "Federal tax not applicable",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
            // Provincial Tax Container
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: [
                      BoxShadow(
                        blurStyle: BlurStyle.solid,
                        blurRadius: 8,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      income.isNotEmpty
                          ? "Provincial Tax: PKR ${provincialTax.toStringAsFixed(2)} /year"
                          : "Provincial tax not applicable",
                      style: TextStyle(
                        fontFamily: 'Jost',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}