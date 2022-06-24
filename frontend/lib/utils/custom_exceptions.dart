class CustomException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  CustomException([this._message, this._prefix]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Erro durante Comunicação: ");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message])
      : super(message, "Requisição Inválida: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message, "Não Autorizado: ");
}

class ObjectNotFoundException extends CustomException {
  ObjectNotFoundException([String? message])
      : super(message, "Object Not Found: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ServerErrorException extends CustomException {
  ServerErrorException([String? message])
      : super(message, "Erro do Servidor: ");
}
