import '../../domain/entities/grade_entity.dart';

class GradeModel extends GradeEntity {
  GradeModel({
    required super.id,
    required super.subjectName,
    required super.grade,
    super.letterGrade,
    required super.date,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      id: json['id'] ?? 0,
      subjectName: json['subject_name'] ?? '',
      grade: (json['grade'] ?? 0).toDouble(),
      letterGrade: json['letter_grade'],
      date: json['date'] ?? json['created_at'] ?? '',
    );
  }
}
