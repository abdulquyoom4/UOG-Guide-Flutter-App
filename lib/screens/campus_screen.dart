import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'webview_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const UOGHeader(
            title: 'Campus Info',
            subtitle: 'MB Sub-Campus details',
            showBack: true,
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
            final ValueNotifier<ThemeMode> themeNotifier =
            ValueNotifier(ThemeMode.light);

              Future<void> saveTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
    'theme',
    mode == ThemeMode.dark ? 'dark' : 'light',
    );
    }

        Future<void> toggleTheme() async {
      if (themeNotifier.value == ThemeMode.light) {
        themeNotifier.value = ThemeMode.dark;
      } else {
        themeNotifier.value = ThemeMode.light;
      }

      await saveTheme(themeNotifier.value);
    }

                Container(
                  margin: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UOG Mandi Bahauddin Sub-Campus',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 12, color: Colors.white70),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Murala Road near DHQ Hospital Mandi Bahauddin',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      const Row(
                        children: [
                          _CampusStat(value: '5+', label: 'Programs'),
                          SizedBox(width: 20),
                          _CampusStat(value: '1000+', label: 'Students'),
                          SizedBox(width: 20),
                          _CampusStat(value: '25+', label: 'Faculty'),
                        ],
                      ),
                    ],
                  ),
                ),


                const SectionLabel('Campus Resources'),

                InfoRow(
                  icon: const Icon(Icons.phone_outlined),
                  title: 'Contact Office',
                  subtitle: '+92-546-123456',
                  onTap: () {},
                ),

                InfoRow(
                  icon: const Icon(Icons.local_library_outlined),
                  title: 'Library',
                  subtitle: 'Mon–Sat, 8am–6pm',
                  onTap: () {},
                ),

                InfoRow(
                  icon: const Icon(Icons.computer_outlined),
                  title: 'Computer Lab',
                  subtitle: '2 labs, 60 computers each',
                  onTap: () {},
                ),

                InfoRow(
                  icon: const Icon(Icons.sports_soccer_outlined),
                  title: 'Sports Grounds',
                  subtitle: 'Cricket, Football, Volleyball',
                  onTap: () {},
                ),

                InfoRow(
                  icon: const Icon(Icons.restaurant_outlined),
                  title: 'Cafeteria',
                  subtitle: '8am–5pm daily',
                  onTap: () {},
                ),


                const SectionLabel('About Us'),

                InfoRow(
                  icon: const Icon(Icons.language),
                  title: 'Portfolio',
                  subtitle: 'abdulquyoom.tech',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const WebViewScreen(
                          url: 'https://abdulquyoom.tech/',
                        ),
                      ),
                    );
                  },
                ),

                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.linkedinIn),
                  title: 'LinkedIn',
                  subtitle: 'Abdul Quyoom',
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://www.linkedin.com/in/abdulquyoom4/');

                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not open LinkedIn'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                ),

                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.github),
                  title: 'Github',
                  subtitle: 'abdulquyoom4',
                  onTap: () async {
                    final Uri url =
                    Uri.parse('https://github.com/abdulquyoom4');

                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Could not open Github'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CampusStat extends StatelessWidget {
  final String value;
  final String label;

  const _CampusStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}