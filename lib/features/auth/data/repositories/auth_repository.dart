import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_response.dart';
import '../../../../core/utils/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../model/user_model.dart';


abstract class AuthDataSource {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String phone,
    required String role,
  });
  Future<Either<Failure, UserEntity>> getMe();
}

class AuthRepository implements AuthDataSource {
  final DioClient _client;

  AuthRepository(this._client);

  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    try {
      final response = await _client.post('/login', queryParameters: {
        'email': email,
        'password': password,
      });
      final token = response['token'];
      final userData = response['user'] ?? response['data']?['user'] ?? response['data'];
      if (token != null && userData is Map<String, dynamic>) {
        final user = UserModel.fromJson({...userData, 'token': token});
        return Right(user);
      }
      return Left(Failure(response['message'] ?? 'Login failed'));
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String phone,
    required String role,
  }) async {
    try {
      final response = await _client.post('/register', queryParameters: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'address': address,
        'phone': phone,
        'role': role,
      });
      final token = response['token'];
      final userData = response['user'] ?? response['data']?['user'] ?? response['data'];
      if (token != null && userData is Map<String, dynamic>) {
        final user = UserModel.fromJson({...userData, 'token': token});
        return Right(user);
      }
      return Left(Failure(response['message'] ?? 'Registration failed'));
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final response = await _client.get('/me');
      final data = response['data'] ?? response['user'] ?? response;
      if (data is Map<String, dynamic>) {
        return Right(UserModel.fromJson(data));
      }
      return Left(Failure('Failed to load profile'));
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }
}
