class Failure {
  bool status; // true or false
  String message; // success message
  int? statusCode;

  Failure(this.status, this.message, {this.statusCode});
}
