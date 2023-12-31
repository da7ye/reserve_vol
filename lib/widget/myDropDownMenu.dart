import 'package:flutter/material.dart';

class MyDropdownMenu extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;

  MyDropdownMenu({
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.0),
        DropdownButton<String>(
          value: value,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          hint: Text(
            'Choose $labelText',
            style: TextStyle(color: Colors.white70),
          ),
          dropdownColor: Colors.blue, // Set the background color here
        ),
      ],
    );
  }
}
