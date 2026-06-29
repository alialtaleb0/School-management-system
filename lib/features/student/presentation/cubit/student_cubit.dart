import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/complete_profile_usecase.dart';
import '../../domain/usecases/enroll_usecase.dart';
import '../../domain/usecases/get_enrollments_usecase.dart';
import '../../domain/usecases/get_grades_usecase.dart';
import 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final CompleteProfileUseCase completeProfileUseCase;
  final EnrollUsecase enrollUseCase;
  final GetEnrollmentsUseCase getEnrollmentsUseCase;
  final GetGradesUseCase getGradesUseCase;

  StudentCubit({
    required this.completeProfileUseCase,
    required this.enrollUseCase,
    required this.getEnrollmentsUseCase,
    required this.getGradesUseCase,
  }) : super(const StudentState());

  Future<void> completeProfile(String dateOfBirth, String studentNumber) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await completeProfileUseCase(
      dateOfBirth: dateOfBirth,
      studentNumber: studentNumber,
    );
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }

  Future<void> enroll(int levelId, int sectionId, String academicYear) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));
    final result = await enrollUseCase(
      levelId: levelId,
      sectionId: sectionId,
      academicYear: academicYear,
    );
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        getEnrollments();
      },
    );
  }

  Future<void> getEnrollments() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await getEnrollmentsUseCase();
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (list) => emit(state.copyWith(isLoading: false, enrollments: list)),
    );
  }

  Future<void> getGrades() async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await getGradesUseCase();
    result.fold(
      (f) => emit(state.copyWith(isLoading: false, error: f.message)),
      (list) => emit(state.copyWith(isLoading: false, grades: list)),
    );
  }

  void clearError() => emit(state.copyWith(error: null));
  void resetSuccess() => emit(state.copyWith(isSuccess: false));
}
