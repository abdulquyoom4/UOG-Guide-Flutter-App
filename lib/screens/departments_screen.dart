import 'package:flutter/material.dart';
import '../widgets/common_widgets.dart';
import 'webview_screen.dart';

class DepartmentsScreen extends StatelessWidget {
  const DepartmentsScreen({super.key});

  static const _departments = [
    {
      'name': 'Computer Science',
      'short': 'BSCS',
      'icon': Icons.computer,
      'years': 4,
      'credits': 136,
      'desc':
      'Core CS topics including algorithms, databases, networks, AI and software engineering.',
      'colors': [Color(0xFF1E40AF), Color(0xFF3B82F6)],
      'studyScheme':
      'https://uog.edu.pk/en/uog-academics/department-of-computer-science/programs',
      'scrollId': '#uogis-data'
    },
    {
      'name': 'Business Administration',
      'short': 'BBA',
      'icon': Icons.bar_chart,
      'years': 4,
      'credits': 130,
      'desc':
      'Business fundamentals covering marketing, finance, management and entrepreneurship.',
      'colors': [Color(0xFF065F46), Color(0xFF10B981)],
      'studyScheme':
      'https://uog.edu.pk/en/uog-academics/department-of-management-sciences/programs',
      'scrollId': '#uogis-data'
    },
    {
      'name': 'English Literature',
      'short': 'BS English',
      'icon': Icons.menu_book,
      'years': 4,
      'credits': 130,
      'desc':
      'Study of language, literature, linguistics, and creative writing.',
      'colors': [Color(0xFF7C2D92), Color(0xFFA855F7)],
      'studyScheme':
      'https://uog.edu.pk/en/uog-academics/department-of-english/programs',
      'scrollId': '#uogis-data'
    },
    {
      'name': 'Mathematics',
      'short': 'BS Math',
      'icon': Icons.functions,
      'years': 4,
      'credits': 130,
      'desc':
      'Pure and applied mathematics including calculus, algebra and statistics.',
      'colors': [Color(0xFF9F1239), Color(0xFFF43F5E)],
      'studyScheme':
      'https://uog.edu.pk/en/uog-academics/department-of-mathematics/programs',
      'scrollId': '#uogis-data'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const UOGHeader(
            title: 'Departments',
            subtitle: 'MB Sub-Campus programs',
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(6, 12, 6, 16),
              itemCount: _departments.length,
              itemBuilder: (context, i) {
                final d = _departments[i];
                return _DepartmentCard(
                  name: d['name'] as String,
                  short: d['short'] as String,
                  icon: d['icon'] as IconData,
                  years: d['years'] as int,
                  credits: d['credits'] as int,
                  desc: d['desc'] as String,
                  colors: d['colors'] as List<Color>,
                  studyScheme: d['studyScheme'] as String,
                  scrollId: d['scrollId'] as String,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _DepartmentCard extends StatefulWidget {
  final String name;
  final String short;
  final IconData icon;
  final int years;
  final int credits;
  final String desc;
  final List<Color> colors;
  final String studyScheme;
  final String scrollId;

  const _DepartmentCard({
    required this.name,
    required this.short,
    required this.icon,
    required this.years,
    required this.credits,
    required this.desc,
    required this.colors,
    required this.studyScheme,
    required this.scrollId,
  });

  @override
  State<_DepartmentCard> createState() => _DepartmentCardState();
}

class _DepartmentCardState extends State<_DepartmentCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor, width: 0.5),
        ),
        child: Column(
          children: [
            Container(
              height: 58,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? widget.colors.map((c) => c.withOpacity(0.85)).toList()
                      : widget.colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(14)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(widget.icon, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 17),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.short,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white70,
                    size: 20,
                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.fromLTRB(26, 12, 26, 12),
              child: Row(
                children: [
                  _StatChip(label: '${widget.years} Years'),
                  const SizedBox(width: 8),
                  _StatChip(label: '${widget.credits} Credit Hrs'),
                  const SizedBox(width: 8),
                  const _StatChip(label: '8 Semesters'),
                ],
              ),
            ),

            // ── Expanded Section ──────────────────────────────────────
            if (_expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Divider(color: theme.dividerColor),
                    const SizedBox(height: 10),
                    Text(
                      widget.desc,
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.textTheme.bodySmall?.color,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),

                    OutlinedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                WebViewScreen(
                                    url: widget.studyScheme,
                                    scrollSelector: widget.scrollId),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.onSurface,
                        side: BorderSide(
                          color: theme.colorScheme.outline,
                          width: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: const Text(
                        'View Study Scheme',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  const _StatChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: theme.textTheme.bodySmall?.color,
        ),
      ),
    );
  }
}