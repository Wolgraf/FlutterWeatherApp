enum Status { COMPLETED, ERROR }

class ApiResponse<T> {
  ApiResponse.completed(this.data, {this.statusCode = 200})
      : status = Status.COMPLETED;

  ApiResponse.error({this.message, this.statusCode}) : status = Status.ERROR;

  Status status;
  T data;
  String message;
  int statusCode;

  @override
  String toString() {
    return "\nStatus : $status\nMessage : $message\nData : $data";
  }

  bool hasData() {
    if (status == Status.ERROR)
      return false;
    else
      return data != null;
  }
}
