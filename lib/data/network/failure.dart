import 'package:clean_architecture_with_mvvm/data/network/error_handler.dart';

class Failure {
  int statusCode; // true or false
  String message; // success message

  Failure(this.statusCode, this.message);
}


class DefaultFailure extends Failure{
  DefaultFailure():super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);

}
