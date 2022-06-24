import 'package:flutter/foundation.dart';
import 'package:frontend/constants/http_status.dart';
import 'package:frontend/utils/custom_exceptions.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:io';

class ApiService {
  // final String _baseUri = kDebugMode ? 'https://dirigirassessoria.com.br/';
  final String _baseUri = 'http://192.168.0.103:8000/';

  // final String _baseUri = 'http://192.168.0.103:8080/';

  get(String endpoint,
      {headers = const {'Content-Type': 'application/json'}}) async {
    final url = Uri.parse(_baseUri + endpoint);
    try {
      final responseDecoded = _response(await http.get(url, headers: headers));
      if (kDebugMode) {
        print(responseDecoded);
      }
      return responseDecoded;
    } on SocketException catch (e) {
      rethrow;
    } on FetchDataException catch (e) {
      rethrow;
    } on ObjectNotFoundException catch (e) {
      rethrow;
    } on ServerErrorException catch (e) {
      rethrow;
    } on BadRequestException catch (e) {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  post(String endpoint,
      {Map<String, String> headers = const {'Content-Type': "application/json"},
      required dynamic data}) async {
    final url = Uri.parse(_baseUri + endpoint);
    try {
      final responseDecoded = _response(
          await http.post(url, headers: headers, body: jsonEncode(data)));
      return responseDecoded;
    } on SocketException {
      rethrow;
    } on FetchDataException {
      rethrow;
    } on ObjectNotFoundException {
      rethrow;
    } on ServerErrorException {
      rethrow;
    } on BadRequestException {
      rethrow;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  _response(http.Response response) {
    int statusCode;
    dynamic responseBody;
    try {
      statusCode = response.statusCode;
      responseBody = json.decode(utf8.decode(response.bodyBytes));
    } on NoSuchMethodError {
      throw FetchDataException(
          "Não foi possível estabelecer uma comunicação com o servidor");
    }
    switch (statusCode) {
      case HTTPStatus.ok:
        return responseBody;
      case HTTPStatus.created:
        return responseBody;
      case HTTPStatus.badRequest:
        throw BadRequestException(
          "Houve um problema com alguns campos. Por favor, corrija-os e tente novamente.",
        );
      case HTTPStatus.unauthorized:
        throw UnauthorisedException(
          "Você precisa estar logado para fazer essa operação",
        );
      case HTTPStatus.notFound:
        throw ObjectNotFoundException(responseBody['detail']);
      case HTTPStatus.internalServerError:
        throw ServerErrorException(responseBody['detail']);
      default:
        throw FetchDataException(
            "Aconteceu um erro na comunicação com o servidor com Código HTTP: ${response.statusCode}\nErro: ${responseBody['detail']}");
    }
  }
}

String? getErrorMessage(response) {
  return 'Erro nos campos: ' + response.keys.toList().join(", ") + '.';
}
