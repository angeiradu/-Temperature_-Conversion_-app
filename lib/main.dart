// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _selectedConversion = 'F to C';
  final TextEditingController _controller = TextEditingController();
  String _result = '';
  List<String> _history = [];

  void _convert() {
    final double? inputValue = double.tryParse(_controller.text);
    if (inputValue == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    double convertedValue;
    if (_selectedConversion == 'F to C') {
      convertedValue = (inputValue - 32) * 5 / 9;
    } else {
      convertedValue = inputValue * 9 / 5 + 32;
    }

    setState(() {
      _result = convertedValue.toStringAsFixed(1);
      _history.add('$_selectedConversion: ${inputValue.toStringAsFixed(1)} => $_result');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Converter',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<String>(
                value: _selectedConversion,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedConversion = newValue!;
                  });
                },
                items: <String>['F to C', 'C to F']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter temperature'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _convert,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Convert'),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                  ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
