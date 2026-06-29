
import '../../domain/entities/user_entity.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final UserEntity? user;
  final String? error;

  const AuthState({this.isLoading = false, this.isAuthenticated = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, bool? isAuthenticated, UserEntity? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      error: error,
    );
  }
}
