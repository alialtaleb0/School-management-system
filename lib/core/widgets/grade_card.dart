import 'package:flutter/material.dart';

class GradeCard extends StatelessWidget {
  final String subjectName;
  final double grade;
  final String? date;
  final String? levelName;
  final String? sectionName;

  const GradeCard({
    super.key,
    required this.subjectName,
    required this.grade,
    this.date,
    this.levelName,
    this.sectionName,
  });

  Color _gradeColor() {
    if (grade >= 90) return Colors.green;
    if (grade >= 75) return Colors.blue;
    if (grade >= 60) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subjectName,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  if (date != null) ...[
                    const SizedBox(height: 4),
                    Text(date!, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ],
              ),
            ),
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _gradeColor().withAlpha(30),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  grade.toStringAsFixed(0),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _gradeColor(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
