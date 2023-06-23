enum WhatsappExceptionType {
  failedToConnect,
  unknown,
  connectionFailed,
  unAuthorized,
  inValidContact,
  clientNotConnected,
  clientErrorException,
}

class WhatsappException implements Exception {
  late String message;
  late WhatsappExceptionType exceptionType;
  String? details;
  WhatsappException({
    this.message = "Something went wrong",
    this.exceptionType = WhatsappExceptionType.unknown,
    this.details,
  });

  @override
  String toString() {
    return "[ WhatsappException  type : $exceptionType , message : $message ]";
  }
}
