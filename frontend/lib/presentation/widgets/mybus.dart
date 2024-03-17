import 'package:flutter/material.dart';

class MyBus extends StatelessWidget {
  final String operatorName;
  final String departureTime;
  final String duration;
  final double ticketPrice;
  final String imageUrl;

  const MyBus({
    Key? key,
    required this.operatorName,
    required this.departureTime,
    required this.duration,
    required this.ticketPrice,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Handle tap on the entire card, like showing more details
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade200,
                Colors.blue.shade100,
              ],
            ),
          ),
          child: ListTile(
            leading: Container(
              width: 80,
              height: 80,
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
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text('Departure Time: $departureTime', style: const TextStyle(color: Colors.white)),
                Text('Duration: $duration', style: const TextStyle(color: Colors.white)),
                Text('Ticket Price: $ticketPrice', style: const TextStyle(color: Colors.white)),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {

              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text('Book Now'),
            ),
          ),
        ),
      ),
    );
  }
}
