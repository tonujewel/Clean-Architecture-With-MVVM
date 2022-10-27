import 'dart:developer';

import 'package:clean_architecture_with_mvvm/data/data_sources/local_data_source.dart';
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
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final LocalDataSource _localDataSource;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

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
          return Left(
              Failure(409, response.message ?? ResponseMessage.DEFAULT));
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

  @override
  Future<Either<Failure, Messages>> forgotPassword(
      ForgotRequst forgotRequst) async {
    if (await _networkInfo.isConnected) {
      try {
        // internet connection is okay
        final response = await _remoteDataSource.forgotPassword(forgotRequst);
        if (response.success == ApiInternalStatus.SUCCESS) {
          // success
          // then return right
          return Right(response.toDomain());
        } else {
          //  do error business logic
          // return left
          return Left(
              Failure(409, response.message ?? ResponseMessage.DEFAULT));
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

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        // internet connection is okay
        final response = await _remoteDataSource.reginster(registerRequest);
        if (response.success == ApiInternalStatus.SUCCESS) {
          // success
          // then return right
          return Right(response.toDomain());
        } else {
          //  do error business logic
          // return left
          return Left(
              Failure(409, response.message ?? ResponseMessage.DEFAULT));
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

  // @override
  // Future<Either<Failure, RestaurantData>> getRestaurantData() async {
  //   try {
  //     final response = await _localDataSource.getRestaurantData();
  //     return Right(response.toDomain());
  //   } catch (cacheError) {
  //     if (await _networkInfo.isConnected) {
  //       try {
  //         // internet connection is okay
  //         final response = await _remoteDataSource.getRestaurantData();

  //         if (response.success == ApiInternalStatus.SUCCESS) {
  //           // success
  //           // save reponse to local data source
  //           _localDataSource.saveRestaurantDataToCache(response);
  //           // then return right
  //           return Right(response.toDomain());
  //         } else {
  //           //  do error business logic
  //           // return left
  //           return Left(
  //               Failure(409, response.message ?? ResponseMessage.DEFAULT));
  //         }
  //       } catch (error) {
  //         // Error handle
  //         return Left(ErrorHandler.handle(error).failure);
  //       }
  //     } else {
  //       // internet connection failed
  //       // return left for the error
  //       return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
  //     }
  //   }
  // }

  //.....
  @override
  Future<Either<Failure, RestaurantResult>> getRestaurantData() async {
    try {
      // get from cache
      log("message try");
      final response = await _localDataSource.getRestaurantData();
      return Right(response.toDomain());
    } catch (cacheError) {
      log("message cache");
      // we have cache error so we should call API

      if (await _networkInfo.isConnected) {
        try {
          // its safe to call the API
          final response = await _remoteDataSource.getRestaurantData();

          if (response.success == ApiInternalStatus.SUCCESS) // success
          {
            // return data (success)
            // return right
            // save response to local data source
            _localDataSource.saveRestaurantDataToCache(response);
            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left
            return Left(
                Failure(409, response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return (Left(ErrorHandler.handle(error).failure));
        }
      } else {
        // return connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
