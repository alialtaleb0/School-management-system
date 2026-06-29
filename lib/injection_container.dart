import 'package:get_it/get_it.dart';
import 'core/storage/local_storage.dart';
import 'core/network/dio_response.dart';

import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/student/data/repositories/student_repository.dart';
import 'features/student/domain/usecases/complete_profile_usecase.dart';
import 'features/student/domain/usecases/enroll_usecase.dart';
import 'features/student/domain/usecases/get_enrollments_usecase.dart';
import 'features/student/domain/usecases/get_grades_usecase.dart';
import 'features/student/presentation/cubit/student_cubit.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingletonAsync<LocalStorage>(() async => LocalStorage());
  await sl.isReady<LocalStorage>();

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(sl()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(
    loginUseCase: sl(),
    registerUseCase: sl(),
    localStorage: sl(),
  ));

  sl.registerLazySingleton<StudentRepository>(() => StudentRepository(sl()));
  sl.registerLazySingleton<CompleteProfileUseCase>(() => CompleteProfileUseCase(sl()));
  sl.registerLazySingleton<EnrollUsecase>(() => EnrollUsecase(sl()));
  sl.registerLazySingleton<GetEnrollmentsUseCase>(() => GetEnrollmentsUseCase(sl()));
  sl.registerLazySingleton<GetGradesUseCase>(() => GetGradesUseCase(sl()));
  sl.registerFactory<StudentCubit>(() => StudentCubit(
    completeProfileUseCase: sl(),
    enrollUseCase: sl(),
    getEnrollmentsUseCase: sl(),
    getGradesUseCase: sl(),
  ));

}
