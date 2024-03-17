import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/mybus.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const  Icon(
            Icons.arrow_back_ios, 
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context)
                .pop();
          },
        ),
        title: const Text(
          'Search Bus',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[300],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Available Buses',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  MyBus(
                    operatorName: 'Bus Operator',
                    departureTime: '10:00 AM',
                    duration: '4 hours',
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRD494DImPKg6lVywgMlfA0N_-QKit_zobQ6w&usqp=CAU',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
