import 'package:get_it/get_it.dart';
import 'package:gorouter_auth/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:gorouter_auth/features/auth/data/data_source/auth_local_datasource_impl.dart';
import 'package:gorouter_auth/features/auth/domain/use_case/is_logged_in_use_case.dart';
import 'package:gorouter_auth/features/auth/domain/use_case/login_use_case.dart';
import 'package:gorouter_auth/features/auth/presentation/controller/auth_bloc.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';

final injector = GetIt.instance;

Future<void> initDependencies() async {

  /// Data Source ///
  injector.registerLazySingleton<AuthLocalDataSource>(() =>
      AuthLocalDataSourceImpl());

  /// Repository ///
  injector.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(authLocalDataSource: injector()));

  /// UseCase ///
  injector.registerLazySingleton(() =>
      LoginUseCase(authRepository: injector()));
  injector.registerLazySingleton(() =>
      IsLoggedInUseCase(authRepository: injector()));

  /// BloC ///
  injector.registerFactory(() =>
      AuthBloc(isLoggedInUseCase: injector(), loginUseCase: injector()));

  await injector<AuthLocalDataSource>().initDb();
}
