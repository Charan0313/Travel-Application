import 'package:flutter/material.dart';
import 'package:frontend/presentation/screens/search_screen.dart';
import 'package:frontend/presentation/widgets/mycalender.dart';
import 'package:frontend/presentation/widgets/mylocationbar.dart';
import 'package:frontend/presentation/widgets/mytextbutton.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  "Raj Kalpana Travels",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "safe and secure travel",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const MyLocationBar(
                  hintText: 'From',
                ),
                const MyLocationBar(
                  hintText: 'To',
                ),
                const MyCalendar(),
                const SizedBox(height: 30),
                MyTextButton(
                  text: 'Search Ticket',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScreen()),
                    );
                  },
                  textColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 84, 167, 235),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
