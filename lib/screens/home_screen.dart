import 'package:flutter/material.dart';
import 'package:uog_guide/screens/campus_screen.dart';
import '../widgets/common_widgets.dart';
import 'gpa_screen.dart';
import 'departments_screen.dart';
import 'webview_screen.dart';
import 'timetable_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const UOGHeader(
            title: 'UOG Guide',
            subtitle: 'University of Gujrat — Mandi Bahauddin',
            showBadge: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuickCard(
                        icon: Icons.menu_book_outlined,
                        title: 'LMS',
                        subtitle: 'Learning Management',
                        iconBg: const Color(0xFFCCFBF1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const WebViewScreen(
                                      url: 'https://lms.uog.edu.pk/')));
                        },
                      ),
                      QuickCard(
                        icon: Icons.edit_document,
                        title: 'CMS',
                        subtitle: 'Campus Management',
                        iconBg: const Color(0xFFDBEAFE),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const WebViewScreen(
                                      url: 'https://cms.uog.edu.pk/')));
                        },
                      ),
                      QuickCard(
                        icon: Icons.receipt_long_outlined,
                        title: 'Academic Calendar',
                        subtitle: 'Yearly Study Schedule',
                        iconBg: const Color(0xFFDCFCE7),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const WebViewScreen(
                                    url:
                                    'https://docs.google.com/gview?embedded=true&url=https://uog.edu.pk/downloads/academic2025-26.pdf',
                                  )));
                        },
                      ),
                      QuickCard(
                        icon: Icons.pin_drop_outlined,
                        title: 'Campus Info',
                        subtitle: 'All About UOG Mandi',
                        iconBg: const Color(0xFFFCE7F3),
                        onTap: () {
                          Navigator.push(
                              context,
                             MaterialPageRoute(builder: (context)=> const CampusScreen())
                          );
                        },
                      ),
                      QuickCard(
                        icon: Icons.view_week,
                        title: 'Time Table',
                        subtitle: 'Daily Classes Schedule',
                        iconBg: const Color(0xDDFCE1C3),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context)=> const TimeTableScreen())
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}