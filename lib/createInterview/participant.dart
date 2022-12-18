// ignore_for_file: avoid_print, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insterviewschedule/createInterview/create_inter.dart';
import 'package:insterviewschedule/createInterview/particant_card.dart';

class Participant extends StatefulWidget {
  const Participant({super.key});
  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> {
  final List<String> selected = [];
  final ScrollController controller = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> participant = [];
  DocumentSnapshot? lastDocument;
  bool isMoreData = true;
  bool isLoading = false;
  Future<void> getdata() async {
    print('i am called');
    if (isMoreData) {
      setState(() {
        isLoading = true;
      });
      final collectionReference = _db.collection('participants');
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (lastDocument == null) {
        try {
          querySnapshot = await collectionReference.limit(10).get();
        } catch (e) {
          print(e);
        }
      } else {
        try {
          querySnapshot = await collectionReference
              .limit(10)
              .startAfterDocument(lastDocument!)
              .get();
        } catch (e) {
          print(e);
        }
      }
      lastDocument = querySnapshot.docs.last;
      participant.addAll(querySnapshot.docs.map((e) => e.data()));
      isLoading = false;
      if (querySnapshot.docs.length < 10) {
        isMoreData = false;
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      print('no more data');
    }
  }

  @override
  void initState() {
    super.initState();
    getdata();
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        getdata();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(210, 8, 8, 8),
        title: const Text(
          "Scalar",
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: participant.length,
          controller: controller,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: ParticipantList(
              data: participant[index],
              selected: selected,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selected.length > 1) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text(
                  'Select Schedule',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                actionsAlignment: MainAxisAlignment.start,
                actions: [
                  ScheduleMeet(participants: selected),
                ],
              ),
            );
          } else {
            var snack = SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
              content: Text(
                'No. of Selected Participants should be greater than 1',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  // color: Colors.black,
                ),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          }
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
