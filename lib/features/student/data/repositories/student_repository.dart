import 'package:dartz/dartz.dart';
import 'package:school_managment_system/core/network/api_consatnt.dart';
import 'package:school_managment_system/core/network/dio_response.dart';
import 'package:school_managment_system/features/student/data/model/enrollment_model.dart';
import 'package:school_managment_system/features/student/data/model/grade_model.dart';
import 'package:school_managment_system/features/student/domain/entities/enrollment_entity.dart';
import 'package:school_managment_system/features/student/domain/entities/grade_entity.dart';

import '../../../../core/utils/failure.dart';

class StudentRepository {
  final DioClient _client;
  StudentRepository(this._client);
  Future<Either<Failure, void>> completeProfile({
    required String dateOfBirth,
    required String studentNumber,
  }) async {
    try {
      await _client.UplodaeFile(
        ApiConsatnt.completeProfile,
        fileds: {'date_of_birth': dateOfBirth, 'student_number': studentNumber},
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }

  Future<Either<Failure, void>> enroll({
    required int levelId,
    required int sectionId,
    required String academicYear,
  }) async {
    try {
      await _client.UplodaeFile(
        ApiConsatnt.enroll,
        fileds: {
          'level_id': levelId,
          'section_id': sectionId,
          'academic_year': academicYear,
        },
      );
      return const Right(null);
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }

  Future<Either<Failure, List<EnrollmentEntity>>> getMyEnrollments() async {
    try {
      final response = await _client.get(ApiConsatnt.myEnrollments);
      final data = response['data'] ?? response['enrollments'] ?? [];
      if (data is List) {
        return Right(
          data
              .map((e) => EnrollmentModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      return Left(Failure('Invalid data format'));
    } catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }

  Future<Either<Failure, List<GradeEntity>>> getGrades() async {
    try {
      final response = await _client.get(ApiConsatnt.grades);
      final data = response['data'] ?? response['grades'] ?? [];
      if (data is List) {
        return Right(
          data
              .map((e) => GradeModel.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }
      return Left(Failure('Invalid data format'));
    } on Exception catch (e) {
      return Left(Failure('Connection error: $e'));
    }
  }
}
