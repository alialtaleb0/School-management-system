
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/local_storage.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LocalStorage localStorage;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.localStorage,
  }) : super(const AuthState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await loginUseCase(email, password);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (user) {
        if (user.token != null) localStorage.saveToken(user.token!);
        emit(state.copyWith(isLoading: false, isAuthenticated: true, user: user));
      },
    );
  }

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String phone,
    required String role,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await registerUseCase(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      address: address,
      phone: phone,
      role: role,
    );
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, error: failure.message)),
      (user) {
        if (user.token != null) localStorage.saveToken(user.token!);
        emit(state.copyWith(isLoading: false, isAuthenticated: true, user: user));
      },
    );
  }

  Future<void> logout() async {
    await localStorage.removeToken();
    emit(const AuthState());
  }

  void clearError() => emit(state.copyWith(error: null));
}
