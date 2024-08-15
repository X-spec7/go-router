import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gorouter_auth/core/use_case/base_use_case.dart';
import 'package:gorouter_auth/features/auth/domain/use_case/is_logged_in_use_case.dart';
import 'package:gorouter_auth/features/auth/domain/use_case/login_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.loginUseCase, required this.isLoggedInUseCase})
      : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        final response = await loginUseCase(true);
        response.fold(
          (l) => emit(const AuthState.failed()),
          (r) => emit(AuthState.success(r)),
        );
      } else if (event is IsLoggedInEvent) {
        final response = await isLoggedInUseCase(const DefaultParams());
        response.fold(
          (l) => emit(const AuthState.failed()),
          (r) {
            if (r) {
              emit(AuthState.success(r));
            } else {
              emit(const AuthState.failed());
            }
          },
        );
      } else if (event is LogoutEvent) {
        // Handle logout logic here
        final response = await loginUseCase(false);
        response.fold(
          (l) => emit(const AuthState.failed()),
          (r) => emit(const AuthState.initial()),
        );
      }
    });
  }
}
