import 'package:clean_architecture_with_mvvm/data/data_sources/remote_data_sources.dart';
import 'package:clean_architecture_with_mvvm/data/mapper/mapper.dart';
import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';
import 'package:clean_architecture_with_mvvm/data/network/network_info.dart';
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/data/request/request.dart';
import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl extends Repository {
  RemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // internet connection is okay
        final response = await _remoteDataSource.login(loginRequest);

        if (response.success == ApiInternalStatus.SUCCESS) {
          // success
          // then return right
          return Right(response.toDomain()); // -> its convert response to model
        } else {
          //  do error business logic
          // return left
          return Left(Failure(409, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        // Error handle 
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // internet connection failed
      // return left for the error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
