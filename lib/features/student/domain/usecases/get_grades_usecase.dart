import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';
import '../../data/repositories/student_repository.dart';
import '../entities/grade_entity.dart';

class GetGradesUseCase {
  final StudentRepository _repository;
  GetGradesUseCase(this._repository);

  Future<Either<Failure, List<GradeEntity>>> call() => _repository.getGrades();
}
