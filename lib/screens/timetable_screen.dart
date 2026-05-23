import 'package:flutter/material.dart';
import 'package:uog_guide/widgets/common_widgets.dart';


class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({super.key});

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          UOGHeader(title: "Time Table", subtitle: "Department Wise Class Schedule", showBack: true,),
          SizedBox(height: 250,),
          Center(
            child: Text("Coming Soon..."),
          )
        ],
      ),
    );
  }
}
