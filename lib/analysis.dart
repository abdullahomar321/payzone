import 'package:flutter/material.dart';
import 'package:payzone/dashboard.dart';

class analysis extends StatefulWidget {
  const analysis({super.key});

  @override
  State<analysis> createState() => _analysisState();
}

class _analysisState extends State<analysis> {
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController assetsController = TextEditingController();
  final TextEditingController expensesController = TextEditingController();
  final TextEditingController monthlyCosts = TextEditingController();

  double? totalincome;
  double? savings;
  String deficit = "";
  String solvency = "";

  void CalculatePerformance() {
    double salary = double.tryParse(salaryController.text) ?? 0;
    double assetRevenue = double.tryParse(assetsController.text) ?? 0;
    double expenses = double.tryParse(expensesController.text) ?? 0;
    double liabilities = double.tryParse(monthlyCosts.text) ?? 0;

    setState(() {
      totalincome = salary + assetRevenue;
      savings = salary - expenses;

      if (expenses <= (0.3 * totalincome!)) {
        deficit = "No Deficit";
      } else {
        deficit = "You are in Deficit";
      }

      if (liabilities > assetRevenue) {
        solvency = "You are Bankrupt";
      } else {
        solvency = "You maintained solvency";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 60,
            backgroundColor: Colors.pinkAccent,
            leading: IconButton(
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
          SliverToBoxAdapter(
            child: SizedBox(height: 30),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Icon(
                Icons.analytics_outlined,
                size: 140,
                color: Colors.black,
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: expensesController,
                    style: TextStyle(fontSize: 31, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter Expenses',
                      hintStyle: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jost',
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: assetsController,
                    style: TextStyle(fontSize: 31, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter revenue',
                      hintStyle: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jost',
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: monthlyCosts,
                    style: TextStyle(fontSize: 31, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter liabilities',
                      hintStyle: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jost',
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: TextField(
                    controller: salaryController,
                    style: TextStyle(fontSize: 31, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter salary/month',
                      hintStyle: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Jost',
                        color: Colors.black,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: CalculatePerformance,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Card(
                  color: Colors.purple.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Income:📊 ${totalincome?.toStringAsFixed(2) ?? '--'}",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold,fontFamily: 'Jost'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Savings:💰 ${savings?.toStringAsFixed(2) ?? '--'}",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold,fontFamily: 'Jost'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Deficit Status:⚠️ $deficit",
                          style: TextStyle(
                              fontSize: 23,fontWeight: FontWeight.bold,fontFamily: 'Jost'),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Solvency Status:🏦 $solvency",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.bold,fontFamily: 'Jost'),
                        ),
                      ],
                    ),
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
