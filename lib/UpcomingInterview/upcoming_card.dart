// ignore_for_file: unnecessary_import, sized_box_for_whitespace, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, non_constant_identifier_names, prefer_typing_uninitialized_variables


import 'package:flutter/material.dart';
import 'package:insterviewschedule/backend/edit_process.dart';
import 'package:insterviewschedule/UpcomingInterview/edit_schedule.dart';

class UpcomingCard extends StatefulWidget {
  final data;
  const UpcomingCard({Key? key, required this.data}) : super(key: key);

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  @override
  Widget build(BuildContext context) {
    final Height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Card(
        color: Color.fromARGB(255, 221, 221, 221),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Upcoming Interview',
                    style: TextStyle(
                      color: Colors.indigo.shade900,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 105,
                  ),
                  Container(
                    // color: Colors.red,
                    height: 25,
                    width: 25,
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  'Select Schedule',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                actionsAlignment: MainAxisAlignment.start,
                actions: [
                  EditSchedule(interId: widget.data['interId'],participant: widget.data['participant'],start: widget.data['startTime']),
                ],
              ),
            );
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Date: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                      child: Text(
                    '${widget.data['date'].toString().substring(0,4)}/${widget.data['date'].toString().substring(4,6)}/${widget.data['date'].toString().substring(6,8)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Start At: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      '${widget.data['startTime'].toString().substring(0,2)}:${widget.data['startTime'].toString().substring(2,4)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'End At: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                     '${widget.data['endTime'].toString().substring(0,2)}:${widget.data['endTime'].toString().substring(2,4)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Number of Participants: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      widget.data['no_of_participant'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
