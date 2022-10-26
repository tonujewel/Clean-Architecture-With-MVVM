import 'package:clean_architecture_with_mvvm/data/network/failure.dart';
import 'package:clean_architecture_with_mvvm/domain/repositories/repository.dart';
import 'package:clean_architecture_with_mvvm/domain/use_case/base_use_case.dart';
import 'package:dartz/dartz.dart';
import '../model/model.dart';

class RestaurantUseCase extends BaseUseCase<void, RestaurantData> {
  final Repository _repository;
  RestaurantUseCase(this._repository);
  @override
  Future<Either<Failure, RestaurantData>> execute(void input) async {
    return await _repository.getRestaurantData();
  }
}
