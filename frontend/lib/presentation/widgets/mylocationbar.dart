import 'package:flutter/material.dart';

class MyLocationBar extends StatelessWidget {
  const MyLocationBar({Key? key, required this.hintText}) : super(key: key);
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: const Icon(Icons.location_on),
          filled: true,
          fillColor: Colors.grey[200],
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
          ),
        ),
      ),
    );
  }
}
