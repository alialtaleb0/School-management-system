class GradeEntity {
  final int id;
  final String subjectName;
  final double grade;
  final String? letterGrade;
  final String date;

  GradeEntity({
    required this.id,
    required this.subjectName,
    required this.grade,
    this.letterGrade,
    required this.date,
  });
}
