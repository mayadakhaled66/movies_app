class ErrorResponse{
  String errorMessage;
  String errorCode;
  String? errorDetails;

  ErrorResponse({required this.errorCode,required this.errorMessage , this.errorDetails});
}