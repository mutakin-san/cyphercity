class ApiReturnValue<T> {
  final T? data;
  final String? message;

  const ApiReturnValue({this.data, this.message});
}