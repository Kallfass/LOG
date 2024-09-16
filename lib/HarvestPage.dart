import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:log/Http_handler.dart';
import 'package:quickalert/quickalert.dart';

class Harvest extends StatefulWidget {
  @override
  _HarvestState createState() => _HarvestState();
}

class _HarvestState extends State<Harvest> {
  String? selectedZone = '1'; // Initial value for the dropdown.
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
            Text('Select a Zone'),
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
                  items: ['1', '2', '3', '4', '5', '6', '7', '8']
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
            Text('Select a number between 1 and 99'),
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
            Text('Enter the mass you want to add to the selected tree'),
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
            SizedBox(height: 30.0),
            Center(
              child: Container(
                width: 200,
                height: 60,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Warte auf die Antwort der HTTP-Anfrage
                      final response = await Http_handler().post_tree_info(
                        number_controller.text,
                        selectedZone,
                        mass_controller.text,
                      );

                      // Überprüfe den Statuscode der Antwort
                      if (response.statusCode == 200) {
                        // Erfolg - zeige Erfolgsmeldung
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Baum wurde eingetragen',
                        );
                      } else {
                        // Fehler - zeige Fehlermeldung
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: 'Sorry, something went wrong. Status code: ${response.statusCode}',
                        );
                      }
                    } catch (e) {
                      // Netzwerk- oder andere Fehler behandeln
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Oops...',
                        text: 'Sorry, something went wrong. Error: $e',
                      );
                    }
                  },
                    child: Text('Send HTTP Request'),
                  )

               ),
            ),
          ],
        ),
      ),
    );
  }
}
