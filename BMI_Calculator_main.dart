import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  double? _bmi;
  String? _message;

  void _calculateBMI() {
    final double height = double.tryParse(heightController.text) ?? 0.0;
    final double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      setState(() {
        _bmi = weight / (height * height);
        if (_bmi! < 18.5) {
          _message = 'You are underweight.';
        } else if (_bmi! < 24.9) {
          _message = 'You have a normal weight.';
        } else if (_bmi! < 29.9) {
          _message = 'You are overweight.';
        } else {
          _message = 'You are obese.';
        }
      });
    } else {
      setState(() {
        _message = 'Please enter valid values.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Height (m)',
                labelStyle: TextStyle(color: Colors.tealAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.tealAccent),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBMI,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            if (_bmi != null)
              Text(
                'Your BMI is: ${_bmi!.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24, color: Colors.tealAccent),
              ),
            if (_message != null)
              Text(
                _message!,
                style: TextStyle(fontSize: 18, color: Colors.tealAccent),
              ),
          ],
        ),
      ),
    );
  }
}
