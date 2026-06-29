import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';
import '../../data/repositories/student_repository.dart';

class EnrollUsecase {
  final StudentRepository _repositry;
  EnrollUsecase(this._repositry);

  Future<Either<Failure, void>> call({
    required int levelId,
    required int sectionId,
    required String academicYear,
  }) {
    return _repositry.enroll(
      levelId: levelId,
      sectionId: sectionId,
      academicYear: academicYear,
    );
  }
}
