import 'package:dartz/dartz.dart';
import 'package:gorouter_auth/core/error/failure.dart';
import 'package:gorouter_auth/features/auth/data/data_source/auth_local_datasource.dart';
import 'package:gorouter_auth/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/error/exceptions.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthLocalDataSource authLocalDataSource;

  AuthRepositoryImpl({required this.authLocalDataSource});

  @override
  Future<Either<Failure, bool>> isLoggedIn() async{
    try{
      final response = await authLocalDataSource.isLoggedIn();
      return Right(response);
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signIn(bool status) async {
    try{
      final response = await authLocalDataSource.signIn(status);
      return Right(response);
    } on ConnectionException {
      return Left(ConnectionFailure());
    }
  }
}
