import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Future<void> openExternalApp(String link) async {
      final Uri uri = Uri.parse(
       link
      );
      try {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [

          const UOGHeader(
            title: 'My Profile',
            subtitle: 'Manage your account',
          ),

          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const SizedBox(height: 26),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor:
                        AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: isDark
                              ? AppColors.primaryLight
                              : AppColors.primary,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        user?.displayName ?? 'No Name Provided',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 4),

                      Text(
                        user?.email ?? 'No Email',
                        style: TextStyle(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 8),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Student',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // Logout Button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();

                        if (context.mounted) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        }
                      },
                      icon: const Icon(Icons.logout),

                      label: const Text('Sign Out'),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // About Section
                const SectionLabel('About Us'),

                InfoRow(
                  icon: const Icon(Icons.language),
                  title: 'Portfolio',
                  subtitle: 'abdulquyoom.tech',
                  onTap: () {
                    openExternalApp('https://abdulquyoom.tech/');
                  },
                ),

                InfoRow(
                  icon: const FaIcon(
                    FontAwesomeIcons.linkedinIn,
                  ),
                  title: 'LinkedIn',
                  subtitle: 'Abdul Quyoom',
                  onTap: () {
                    openExternalApp('https://www.linkedin.com/in/abdulquyoom4/');
                  },
                ),

                InfoRow(
                  icon: const FaIcon(
                    FontAwesomeIcons.github,
                  ),
                  title: 'Github',
                  subtitle: 'abdulquyoom4',
                  onTap: () {
                    openExternalApp('https://www.linkedin.com/in/abdulquyoom4/');
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
