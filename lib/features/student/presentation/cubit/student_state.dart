import '../../domain/entities/enrollment_entity.dart';
import '../../domain/entities/grade_entity.dart';

class StudentState {
  final bool isLoading;
  final bool isSuccess;
  final List<EnrollmentEntity> enrollments;
  final List<GradeEntity> grades;
  final String? error;

  const StudentState({
    this.isLoading = false,
    this.isSuccess = false,
    this.enrollments = const [],
    this.grades = const [],
    this.error,
  });

  StudentState copyWith({
    bool? isLoading,
    bool? isSuccess,
    List<EnrollmentEntity>? enrollments,
    List<GradeEntity>? grades,
    String? error,
  }) {
    return StudentState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      enrollments: enrollments ?? this.enrollments,
      grades: grades ?? this.grades,
      error: error,
    );
  }
}
