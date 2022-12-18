
// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:insterviewschedule/backend/edit_process.dart';

class EditSchedule extends StatefulWidget {
  final interId;
  final participant;
  final start;
  const EditSchedule({Key?key,required this.interId,required this.participant,required this.start}):super(key: key);

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  bool isClicked=false;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay time1 = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final hours1 = time1.hour.toString().padLeft(2, '0');
    final minutes1 = time1.minute.toString().padLeft(2, '0');
    return Container(
      padding: EdgeInsets.only(left: 18),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Select Date: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (newDate == null) {
                    return;
                  }
                  setState(() {
                    date = newDate;
                  });
                },
                child: Text('${date.day}/${date.month}/${date.year}'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Start Time: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (newTime == null) {
                    return;
                  }
                  setState(() {
                    time = newTime;
                  });
                },
                child: Text('$hours:$minutes'),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'End Time:   ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                width: 10,
              ),
              TextButton(
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: time1,
                  );
                  if (newTime == null) {
                    return;
                  }
                  setState(() {
                    time1 = newTime;
                  });
                },
                child: Text('$hours1:$minutes1'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              SizedBox(width: 115),
              // TextButton(
              //   onPressed: () {},
              //   child:
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(width: 30),
              // ),
              // TextButton(
              //   onPressed: () {},
              //   child:
              InkWell(
                onTap: () async{
                  setState(() {
                    isClicked=true;
                  });
                    String status = await editschedule(time: time, time1: time1, date: date, selected: widget.interId,participant: widget.participant,start: widget.start);
                    Navigator.of(context).pop();
                    setState(() {
                      isClicked=false;
                    });
                    var snack = SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              content: Text(
                status,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  // color: Colors.black,
                ),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);

                },
                child:isClicked?Text('Wait...'): Text(
                  'Ok',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
