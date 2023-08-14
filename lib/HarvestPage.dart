import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Harvest extends StatefulWidget {
  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  String? selectedZone = 'A'; // Initial value for the dropdown.
  final mass_controller = TextEditingController();
  final number_controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Harvest')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('1. Select a number between 1 and 99'),
            Center(
              child: Container(
                width: 100.0,  // Set this to whatever width you want.
                child: TextField(
                  controller: number_controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,  // This centers the text inside the TextField.
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: "Nummer",
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0), // Adjust the padding for your needs
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('2. Select a letter from A to J'),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 70.0,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(4.0),
                ),// Set this to whatever width you want.
                child: DropdownButton<String>(
                  value: selectedZone,
                  items: ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']
                      .map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontSize: 30.0)),
                      );
                    },
                  ).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedZone = newValue;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('3. Enter the mass you want to add to the selected tree'),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 100.0,  // Set this to whatever width you want.
                child: TextField(
                  controller: mass_controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,  // This centers the text inside the TextField.
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: "Gewicht",
                    contentPadding: EdgeInsets.symmetric(vertical: 20.0), // Adjust the padding for your needs
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 200,
                height: 60,
                child: ElevatedButton (
                  child: Text('Submit'),
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          // Retrieve the text that the user has entered by using the
                          // TextEditingController.
                          content: Text(number_controller.text + " // " + selectedZone! + " // "+ mass_controller.text + " // "),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}