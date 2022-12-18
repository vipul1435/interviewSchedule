import 'package:flutter/material.dart';
import 'package:insterviewschedule/createInterview/participant.dart';
import 'package:insterviewschedule/UpcomingInterview/upcoming_interview.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex1 = 0;
  final screens = const [
    Participant(),
    Upcoming(),
    Text("rajput"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex1],
      bottomNavigationBar: BottomNavigationBar(
        // selectedItemColor: Colors.black,

        selectedLabelStyle: const TextStyle(color: Colors.red),
        // backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              (currentIndex1 == 0)
                  ? Icons.add_circle
                  : Icons.add_circle_outline,
              color: Colors.black,
            ),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              (currentIndex1 == 1)
                  ? Icons.work_history
                  : Icons.work_history_outlined,
              color: Colors.black,
            ),
            label: 'Interviews',
          ),
        ],
        // ),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex1,
        onTap: (index) {
          setState(() {
            currentIndex1 = index;
          });
        },
      ),
    );
  }
}
