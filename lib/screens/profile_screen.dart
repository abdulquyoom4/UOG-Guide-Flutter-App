import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'login_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final isDark = Theme.of(context).brightness == Brightness.dark;

        if (user == null) {
          return _buildLoggedOutUI(context, isDark);
        }

        return _buildLoggedInUI(context, user, isDark);
      },
    );
  }

  Widget _buildLoggedOutUI(BuildContext context, bool isDark) {
    return Scaffold(
      body: Column(
        children: [
          const UOGHeader(
            title: 'Account',
            subtitle: 'Join the community',
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_outline,
                        size: 80,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Personalize Your Experience',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Sign in to save your notes, track your GPA, and access exclusive student features.',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign In / Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoggedInUI(BuildContext context, User user, bool isDark) {
    // Helper to extract Roll No
    String getRollNumber(String? email) {
      if (email == null || !email.contains('@')) return 'No Roll No';
      return email.split('@')[0].toUpperCase();
    }

    Future<void> openExternalApp(String link) async {
      final Uri uri = Uri.parse(link);
      try {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } catch (e) {
        debugPrint(e.toString());
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
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: isDark ? AppColors.primaryLight : AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.displayName ?? 'No Name Provided',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        getRollNumber(user.email),
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton.icon(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      icon: const Icon(Icons.logout),
                      label: const Text('Sign Out'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const SectionLabel('About Developer'),
                InfoRow(
                  icon: const Icon(Icons.language),
                  title: 'Portfolio',
                  subtitle: 'abdulquyoom.tech',
                  onTap: () => openExternalApp('https://abdulquyoom.tech/'),
                ),
                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.linkedinIn, size: 20),
                  title: 'LinkedIn',
                  subtitle: 'Abdul Quyoom',
                  onTap: () => openExternalApp('https://www.linkedin.com/in/abdulquyoom4/'),
                ),
                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.github, size: 20),
                  title: 'Github',
                  subtitle: 'abdulquyoom4',
                  onTap: () => openExternalApp('https://github.com/abdulquyoom4'),
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
