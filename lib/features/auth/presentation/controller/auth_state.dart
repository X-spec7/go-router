part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.success() = _Success;
  const factory AuthState.failed() = _Failed;
}
