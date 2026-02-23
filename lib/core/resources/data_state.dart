import 'package:flutter/services.dart';

abstract class DataState<T> {
  final T? data;
  final PlatformException? error;
  String? message;

  DataState({this.data, this.error, this.message});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess({super.data, super.message});
}

class DataFailed<T> extends DataState<T> {
  DataFailed({super.error, super.message});
}
