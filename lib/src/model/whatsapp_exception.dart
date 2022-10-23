enum WhatsappExceptionType {
  unknown,
  connectionFailed,
  unAuthorized,
  inValidContact,
  clientNotConnected
}

class WhatsappException implements Exception {
  late String message;
  late WhatsappExceptionType exceptionType;
  WhatsappException({
    this.message = "Something went wrong",
    this.exceptionType = WhatsappExceptionType.unknown,
  });
}
