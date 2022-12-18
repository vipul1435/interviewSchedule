// ignore_for_file: avoid_print, prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insterviewschedule/UpcomingInterview/upcoming_card.dart';
class Upcoming extends StatefulWidget {
  const Upcoming({super.key});
  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  final ScrollController controller = ScrollController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Map<String, dynamic>> upcomimg = [];
  DocumentSnapshot? lastDocument;
  bool isMoreData = true;
  bool isLoading = false;
  Future<void> getdata() async {
    if (isMoreData) {
      setState(() {
        isLoading = true;
      });
      final collectionReference = _db.collection('admin').doc('5bm9aepPko2zHf05UI0k').collection('upcomingInterviews');
      late QuerySnapshot<Map<String, dynamic>> querySnapshot;
      if (lastDocument == null) {
        try {
          querySnapshot = await collectionReference.limit(5).get();
        } catch (e) {
          print(e);
        }
      } else {
        try {
          querySnapshot = await collectionReference
              .limit(5)
              .startAfterDocument(lastDocument!)
              .get();
        } catch (e) {
          print(e);
        }
      }
      lastDocument = querySnapshot.docs.last;
      upcomimg.addAll(querySnapshot.docs.map((e) => e.data()));
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
          "Upcoming InterViews",
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: upcomimg.length,
          controller: controller,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: UpcomingCard(
              data: upcomimg[index],
            ),
          ),
        ),
      ),
    );
  }
}
