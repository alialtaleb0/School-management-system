import 'package:dartz/dartz.dart';

import '../../../../core/utils/failure.dart';
import '../../data/repositories/student_repository.dart';
import '../entities/enrollment_entity.dart';

class GetEnrollmentsUseCase {
  final StudentRepository _repository;
  GetEnrollmentsUseCase(this._repository);

  Future<Either<Failure, List<EnrollmentEntity>>> call() =>
      _repository.getMyEnrollments();
}
