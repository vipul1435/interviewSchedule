// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> editschedule(
    {required time,
    required time1,
    required date,
    required selected,
    required participant,
    required start}) async {
  String dd = date.toString().substring(0, 4);
  dd += date.toString().substring(5, 7);
  dd += date.toString().substring(8, 10);
  String tt = time.toString().substring(10, 12);
  tt += time.toString().substring(13, 15);
  String tt1 = time1.toString().substring(10, 12);
  tt1 += time1.toString().substring(13, 15);
  String str = DateTime.now().toString();
  String currnet = str.toString().substring(0, 4);
  currnet += str.toString().substring(5, 7);
  currnet += str.toString().substring(5, 7);
  double interDate = double.parse(dd);
  double interStart = double.parse(tt);
  double interEnd = double.parse(tt1);
  double currnetDate = double.parse(currnet);
  await FirebaseFirestore.instance
      .collection('admin')
      .doc('5bm9aepPko2zHf05UI0k')
      .collection('upcomingInterviews')
      .doc(selected)
      .update({
    'date': interDate,
    'startTime': interStart,
    'endTime': interEnd,
  });
  for (int i = 0; i < participant.length; i++) {
    final refrence = await FirebaseFirestore.instance
        .collection('participants')
        .doc(participant[i])
        .collection('interviews')
        .where('startTime', isEqualTo: start)
        .get();
    final dd = refrence.docs.map((e) => e.id);
    if (dd.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('participants')
          .doc(participant[i])
          .collection('interviews')
          .doc(dd.first)
          .update({
        'date': interDate,
        'startTime': interStart,
        'endTime': interEnd,
      });
    }
  }
  return "Schedule updated successfully";
}
