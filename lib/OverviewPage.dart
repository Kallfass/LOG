import 'package:flutter/material.dart';

class Overview extends StatefulWidget {
@override
_OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  int selectedNumber = 1; // Initial value for the slider.
  String? selectedLetter = 'A'; // Initial value for the dropdown.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page 2')),
      body: Center(child: Text('This is Page 2')),
    );
  }
}
