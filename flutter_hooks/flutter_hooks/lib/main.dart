import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final TextEditingController _initialInvestmentController;
  late final TextEditingController _monthlyContributionController;
  late final TextEditingController _interestRateController;
  late final TextEditingController _timeController;
  String selectedCompoundFrequency = "Annually";
  String finalAmountMessage = '';
  double finalAmount = 0.0;
  final List<String> _options = ["Annually", "Quarterly", "Monthly", "Daily"];
  double initialInvestment = 0.0;
  int years = 0;
  double interestRate = 0.0;

  @override
  void initState() {
    _initialInvestmentController = TextEditingController();
    _monthlyContributionController = TextEditingController();
    _interestRateController = TextEditingController();
    _timeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _initialInvestmentController.dispose();
    _monthlyContributionController.dispose();
    _interestRateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  int getTimesCompounded(String frequency) {
    switch (frequency) {
      case "Annually":
        return 1;
      case "Quarterly":
        return 4;
      case "Monthly":
        return 12;
      case "Daily":
        return 365;
      default:
        return 1;
    }
  }

  double calculateCompoundInterest(
    double principal,
    double monthlyContribution,
    double rate,
    int timesCompounded,
    int years,
  ) {
    double totalAmount = principal;

    for (int i = 0; i < years * timesCompounded; i++) {
      totalAmount += monthlyContribution;
      totalAmount += totalAmount * (rate / timesCompounded / 100);
    }

    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Row(
                  children: [
                    Spacer(),
                    Text('Saving % of your paycheck'),
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 11, 28, 56),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Step 1: Initial Investment',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _initialInvestmentController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Amount of money to invest initially',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 45,
                        color: Colors.green,
                        child: const Row(
                          children: [
                            Text(
                              'Step 2: Contribute',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _monthlyContributionController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Monthly contribution',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 45,
                        color: Colors.green,
                        child: const Row(
                          children: [
                            Text(
                              'Step 3: Interest Rate',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _interestRateController,
                          decoration: const InputDecoration(
                            hintText: 'Estimated Interest rate',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 45,
                        color: Colors.green,
                        child: const Row(
                          children: [
                            Text(
                              'Step 4: Investment TimeFrame',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _timeController,
                          decoration: const InputDecoration(
                            hintText: 'Length of time in years',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Container(
                        height: 45,
                        color: Colors.green,
                        child: const Row(
                          children: [
                            Text(
                              'Step 5: Compound It',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              'Compound Frequency:',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            DropdownButton<String>(
                              value: selectedCompoundFrequency,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              iconSize: 24,
                              elevation: 16,
                              dropdownColor:
                                  const Color.fromARGB(255, 11, 28, 56),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCompoundFrequency = newValue!;
                                });
                              },
                              items: _options.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                double monthlyContribution = 0.0;
                                double initialInvestment = 0.0;

                                // Validate and parse inputs
                                if (_initialInvestmentController
                                    .text.isNotEmpty) {
                                  initialInvestment = double.tryParse(
                                          _initialInvestmentController.text) ??
                                      0.0;
                                }
                                if (_monthlyContributionController
                                    .text.isNotEmpty) {
                                  monthlyContribution = double.tryParse(
                                          _monthlyContributionController
                                              .text) ??
                                      0.0;
                                }
                                if (_interestRateController.text.isNotEmpty) {
                                  interestRate = double.tryParse(
                                          _interestRateController.text) ??
                                      0.0;
                                }
                                if (_timeController.text.isNotEmpty) {
                                  years =
                                      int.tryParse(_timeController.text) ?? 0;
                                }

                                finalAmount = calculateCompoundInterest(
                                  initialInvestment,
                                  monthlyContribution,
                                  interestRate,
                                  getTimesCompounded(selectedCompoundFrequency),
                                  years,
                                );

                                setState(() {
                                  finalAmountMessage =
                                      'After $years years, your investment will be worth \$${finalAmount.toStringAsFixed(2)}';
                                });
                              },
                              child: const Text('Calculate'),
                            ),
                          ],
                        ),
                      ),
                      if (finalAmountMessage.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            finalAmountMessage,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
