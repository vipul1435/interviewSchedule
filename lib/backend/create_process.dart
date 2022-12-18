// ignore_for_file: unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> createInterview(
    {required time, required time1, required date, required selected}) async {
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
  if (interDate < currnetDate) {
    return "Please select a valid date";
  }
  try {
    final result = FirebaseFirestore.instance.collection('participants');
    List check = [];
    for (int i = 0; i < selected.length; i++) {
      final fn = await FirebaseFirestore.instance
          .collection('participants')
          .doc(selected[i])
          .collection('interviews')
          .where('date', isEqualTo: interDate)
          .where('startTime',isEqualTo: interStart)
          .get();
      check.addAll(fn.docs.map((e) => e.id));
    }
    if(check.isNotEmpty){
      return 'A seleceted Participant is already have an Interview at this Schedule';
    }
    final ref = FirebaseFirestore.instance
      .collection('admin')
      .doc('5bm9aepPko2zHf05UI0k')
      .collection('upcomingInterviews')
      .doc();

    String interId = ref.id;
    await ref.set({
      'startTime':interStart,
      'endTime':interEnd,
      'date':interDate,
      'participant':selected,
      'no_of_participant':selected.length,
      'interId':interId,
    });

    for(var i=0;i<selected.length;i++){
      await FirebaseFirestore.instance
      .collection('participants')
      .doc(selected[i])
      .collection('interviews')
      .doc()
      .set({
        'startTime':interStart,
      'endTime':interEnd,
      'date':interDate,
      'interId':interId,
      });
    }
  } catch (e) {
    return e.toString();
  }
  return "Interview Scheduled Successfully";
}
