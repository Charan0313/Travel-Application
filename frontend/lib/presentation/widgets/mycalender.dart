import 'package:flutter/material.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14,right: 130,top: 10,bottom: 10),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          title: Text(
            _selectedDate == null
                ? 'Select Date'
                : ' ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
            style: TextStyle(
              color: _selectedDate == null ? Colors.grey[600] : Colors.black,
            ),
          ),
          onTap: () {
            _selectDate(context);
          },
          leading: Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_down,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
