import 'dart:ffi';

import 'package:flutter/material.dart';
import '../models/models.dart';
import '../widgets/common_widgets.dart';

class GpaScreen extends StatefulWidget {
  const GpaScreen({super.key});

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  final List<Subject> _subjects = [];

  static const _grades = [
    'A+', 'A', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F'
  ];

  double get _gpa => Subject.calculateGPA(_subjects);
  String get _letterGrade => Subject.getLetterGrade(_gpa);

  void _addSubject() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddSubjectSheet(
        onAdd: (subject) {
          setState(() => _subjects.add(subject));
        },
      ),
    );
  }

  void _removeSubject(int index) {
    setState(() => _subjects.removeAt(index));
  }

  void _changeGrade(int index, String newGrade) {
    setState(() => _subjects[index].grade = newGrade);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          const UOGHeader(
            title: 'GPA Calculator',
            subtitle: 'University of Gujrat grading system',
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Semester GPA',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            _gpa.toStringAsFixed(2),
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'out of 4.00',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _letterGrade,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SectionLabel('Subjects'),



                ..._subjects.asMap().entries.map(
                      (entry) => _SubjectRow(
                    index: entry.key,
                    subject: entry.value,
                    grades: _grades,
                    onGradeChanged: (g) =>
                        _changeGrade(entry.key, g),
                    onDelete: () => _removeSubject(entry.key),
                  ),
                ),
                _subjects.isNotEmpty ?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.swipe_left,
                        size: 16,
                        color: theme.hintColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Swipe left to delete subjects',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.hintColor,
                        ),
                      ),

                    ],
                  ),
                ): const SizedBox(),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: _addSubject,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add,
                            size: 16,
                            color: theme.textTheme.bodySmall?.color),
                        const SizedBox(width: 6),
                        Text(
                          'Add Subject',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: theme.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Grade Scale (UOG)',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: _grades.map((g) {
                          final sub = Subject(
                            name: '',
                            creditHours: 0,
                            grade: g,
                          );

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Subject.getGradeBgColor(g),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '$g = ${sub.gradePoints.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Subject.getGradeColor(g),
                              ),
                            ),
                          );
                        }).toList(),
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

class _SubjectRow extends StatelessWidget {
  final int index;
  final Subject subject;
  final List<String> grades;
  final ValueChanged<String> onGradeChanged;
  final VoidCallback onDelete;

  const _SubjectRow({
    required this.index,
    required this.subject,
    required this.grades,
    required this.onGradeChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key('${subject.name}_$index'),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete_outline, color: Colors.red),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(subject.name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      )),
                  Text(
                    '${subject.creditHours} Credit Hours',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Subject.getGradeBgColor(subject.grade),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: subject.grade,
                  isDense: true,
                  items: grades
                      .map(
                        (g) => DropdownMenuItem(
                      value: g,
                      child: Text(g),
                    ),
                  )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) onGradeChanged(v);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddSubjectSheet extends StatefulWidget {
  final ValueChanged<Subject> onAdd;

  const _AddSubjectSheet({required this.onAdd});

  @override
  State<_AddSubjectSheet> createState() => _AddSubjectSheetState();
}

class _AddSubjectSheetState extends State<_AddSubjectSheet> {
  final _nameCtrl = TextEditingController();
  int _credits = 3;
  String _grade = 'B';

  static const _grades = [
    'A+', 'A', 'B+', 'B', 'B-', 'C+', 'C', 'D', 'F'
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        MediaQuery
            .of(context)
            .viewInsets
            .bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Subject',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _nameCtrl,
            decoration: InputDecoration(
              labelText: 'Subject Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _credits,
                  decoration: const InputDecoration(
                    labelText: 'Credit Hours',
                  ),
                  items: [1, 2, 3, 4]
                      .map((c) =>
                      DropdownMenuItem(
                        value: c,
                        child: Text('$c'),
                      ))
                      .toList(),
                  onChanged: (v) => setState(() => _credits = v!),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _grade,
                  decoration: const InputDecoration(
                    labelText: 'Grade',
                  ),
                  items: _grades
                      .map((g) =>
                      DropdownMenuItem(
                        value: g,
                        child: Text(g),
                      ))
                      .toList(),
                  onChanged: (v) => setState(() => _grade = v!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_nameCtrl.text
                    .trim()
                    .isEmpty) return;

                widget.onAdd(
                  Subject(
                    name: _nameCtrl.text.trim(),
                    creditHours: _credits,
                    grade: _grade,
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text('Add Subject'),
            ),
          ),
        ],
      ),
    );
  }
}