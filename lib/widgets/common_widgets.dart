import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../main.dart'; // for themeNotifier + toggleTheme()

// ─────────────────────────────────────────────────────────────
// Section Label
// ─────────────────────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;

  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
          color: isDark
              ? AppColors.darkTextSecondary
              : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Custom App Header (WITH THEME TOGGLE)
// ─────────────────────────────────────────────────────────────
class UOGHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBadge;
  final bool showBack;

  const UOGHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBadge = false,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      color: isDark ? AppColors.darkSurface : AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.of(context).padding.top + 20,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Top Row ───
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (showBack)
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Row(
                    children: [
                      Icon(Icons.arrow_back_ios,
                          color: Colors.white70, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Back',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(),

              // Theme Toggle Button
              IconButton(
                icon: Icon(
                  isDark ? Icons.light_mode : Icons.dark_mode,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await toggleTheme();
                },
              ),
            ],
          ),

          if (showBadge) ...[
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 6, color: Color(0xFF4ADE80)),
                  SizedBox(width: 6),
                  Text(
                    'MbDin Sub-Campus',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],

          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.2,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Quick Card
// ─────────────────────────────────────────────────────────────
class QuickCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBg;
  final VoidCallback? onTap;

  const QuickCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBg,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark
                ? AppColors.darkBorder
                : AppColors.border,
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 18,
                color: iconBg.computeLuminance() > 0.5
                    ? Colors.black54
                    : Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 11,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// Announcement Card
// ─────────────────────────────────────────────────────────────
class AnnouncementCard extends StatelessWidget {
  final List<Map<String, dynamic>> announcements;

  const AnnouncementCard({
    super.key,
    required this.announcements,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark
              ? AppColors.darkBorder
              : AppColors.border,
          width: 0.5,
        ),
      ),
      child: Column(
        children: announcements
            .map(
              (a) => _AnnouncementRow(
            text: a['text'],
            date: a['date'],
            dotColor: a['color'],
            isLast: a == announcements.last,
          ),
        )
            .toList(),
      ),
    );
  }
}

class _AnnouncementRow extends StatelessWidget {
  final String text;
  final String date;
  final Color dotColor;
  final bool isLast;

  const _AnnouncementRow({
    required this.text,
    required this.date,
    required this.dotColor,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.textSecondary,
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

// ─────────────────────────────────────────────────────────────
// Info Row
// ─────────────────────────────────────────────────────────────
class InfoRow extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark
                ? AppColors.darkBorder
                : AppColors.border,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            if (icon != null)
              SizedBox(width: 28, child: icon!),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}