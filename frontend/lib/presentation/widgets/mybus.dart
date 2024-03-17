import 'package:flutter/material.dart';

class MyBus extends StatelessWidget {
  final String operatorName;
  final String departureTime;
  final String duration;
  final String imageUrl;

  const MyBus({
    Key? key,
    required this.operatorName,
    required this.departureTime,
    required this.duration,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: InkWell(
        onTap: () {
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue.shade200, 
          ),
          child: ListTile(
            leading: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              operatorName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  'Departure Time: $departureTime',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Duration: $duration',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
