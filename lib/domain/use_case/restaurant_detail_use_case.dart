import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/domain/model/model.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import '../repositories/repository.dart';

class RestaurantDetailUseCase
    extends BaseUseCase<int, RestaurantDetailsResult> {
  final Repository _repository;
  RestaurantDetailUseCase(this._repository);
  @override
  Future<Either<Failure, RestaurantDetailsResult>> execute(int input) async {
    return await _repository.getRestaurantDetailsData(input);
  }
}
