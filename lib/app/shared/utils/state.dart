abstract class ViewState {}

class Success extends ViewState {
  dynamic data;
  Success({this.data});
}

class Failure extends ViewState {
  String? message;
  Failure({this.message});
}
