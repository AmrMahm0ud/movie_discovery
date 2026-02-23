import 'package:flutter/services.dart';

class ApiChannel {
  static const MethodChannel _channel =
      MethodChannel('com.movie.discovery/network');

  Future<Map<String, dynamic>> get({
    required String baseUrl,
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    final response = await _channel.invokeMethod<Map>('request', {
      'baseUrl': baseUrl,
      'path': path,
      'method': 'GET',
      'queryParams': queryParams ?? {},
      'headers': headers ?? {},
    });

    if (response == null) {
      throw PlatformException(
        code: 'NULL_RESPONSE',
        message: 'Native platform returned null response',
      );
    }

    final result = Map<String, dynamic>.from(response);
    final statusCode = result['statusCode'] as int?;

    if (statusCode == 200) {
      return Map<String, dynamic>.from(result['data'] as Map);
    }

    throw PlatformException(
      code: '${statusCode ?? 0}',
      message: result['error']?.toString() ??
          'Request failed with status $statusCode',
    );
  }
}
