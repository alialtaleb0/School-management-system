import 'package:dartz/dartz.dart';
import 'package:school_managment_system/features/student/data/repositories/student_repository.dart';

import '../../../../core/utils/failure.dart';

class CompleteProfileUseCase {
  final StudentRepository _repositry;
  CompleteProfileUseCase(this._repositry);

  Future<Either<Failure, void>> call({
    required String dateOfBirth,
    required String studentNumber,
  }) async {
    return _repositry.completeProfile(
      dateOfBirth: dateOfBirth,
      studentNumber: studentNumber,
    );
  }
}
