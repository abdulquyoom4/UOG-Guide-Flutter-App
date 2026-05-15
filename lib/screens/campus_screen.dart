import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'Could not launch dialer';
      }
    }


    Future<void> openExternalApp(String link) async {
      final Uri uri = Uri.parse(
        link,
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

    Future<void> sendEmail() async {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: 'mandi@uog.edu.pk',
      );

      await launchUrl(emailUri);
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const UOGHeader(
            title: 'Campus Info',
            subtitle: 'Sub-Campus Mandi Bahauddin details',
            showBack: true,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
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

                const SectionLabel('Contact Details'),

                InfoRow(
                  icon: const Icon(Icons.phone_outlined),
                  title: 'Contact Office',
                  subtitle: '0546-650410',
                  onTap: () {
                    makePhoneCall('0546-650410');
                  },
                ),
                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.whatsapp),
                  title: 'WhatsApp',
                  subtitle: '0340-3777544',
                  onTap: () {
                    openExternalApp('whatsapp://send?phone=+923403777544');
                  },
                ),
                InfoRow(
                  icon: const Icon(Icons.email_outlined),
                  title: 'Email',
                  subtitle: 'mandi@uog.edu.pk',
                  onTap: () {
                    sendEmail();
                  },
                ),

                const SectionLabel('Social Links'),
                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                  title: 'Facebook',
                  subtitle: 'University of Gujrat Sub Campus',
                  onTap: () {
                    openExternalApp('https://www.facebook.com/share/1LR5exbYCh/');
                  },
                ),
                InfoRow(
                  icon: const FaIcon(FontAwesomeIcons.instagram),
                  title: 'Instagram',
                  subtitle: 'uogmbdincampus',
                  onTap: () {
                    openExternalApp('https://www.instagram.com/uogmbdincampus/');
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

  const _CampusStat({required this.value, required this.label});

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
          style: theme.textTheme.bodySmall?.copyWith(color: Colors.white70),
        ),
      ],
    );
  }
}