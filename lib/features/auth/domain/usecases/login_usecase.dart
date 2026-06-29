import 'package:dartz/dartz.dart';
import '../../../../core/utils/failure.dart';
import '../../data/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository _repository;
  LoginUseCase(this._repository);

  Future<Either<Failure, UserEntity>> call(String email, String password) {
    return _repository.login(email, password);
  }
}
