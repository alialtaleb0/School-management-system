
import '../../domain/entities/enrollment_entity.dart';

class EnrollmentModel  extends EnrollmentEntity{
  EnrollmentModel({
    required super.id,
    required super.levelId,
    required super.sectionId,
    required super.academicYear,
    super.levelName,
    super.sectionName,
    required super.createdAt,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id']?? 0,
      levelId: json['level_id']?? 0,
      sectionId: json['section_id']?? 0,
      academicYear: json['academic_year']?? '',
      levelName: json['level_name']?? '',
      sectionName: json['section_name']?? '',
      createdAt: json['created_at']?? '',
    );
  }
  
}