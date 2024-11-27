import 'package:dio/dio.dart';

import '../../constants/app_api_constant.dart';
import '../../constants/app_constant.dart';

class DioHelper {
  /// Create a new Dio instance to handle all requests
  static late Dio _dio;

  /// initialize Dio instance with base options
  static initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppApiConstants.BASEURL,
        connectTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50),
        sendTimeout: const Duration(seconds: 50),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  /// Create a Generic getData for all GET requests
  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer ${AppConstantsHelper.token}',
      'Content-Type': 'application/json',
    };
    try {
      final Response response = await _dio.get(
        endPoint,
        queryParameters: queryParameters,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Create a Generic postData for all POST requests
  static Future<Response> postData({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer ${AppConstantsHelper.token}',
      'Content-Type': 'application/json',
    };
    try {
      final Response response = await _dio.post(
        endPoint,
        data: body,
        queryParameters: queryParameters,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  //This Function That's Used to Update Some Date based on URL(End Points) and Send what's you need to Update as Map.
  static Future<Response> patchData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    _dio.options.headers = {
      'Authorization': 'Bearer ${AppConstantsHelper.token}',
      'Content-Type': 'application/json',
    };
    return await _dio.patch(
      url,
      data: data,
    );
  }

  //This Function that's Used To Delete Data to API based on URL(End Points) and Headers.
  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      _dio.options.headers = {
        'Authorization': 'Bearer ${AppConstantsHelper.token}',
        'Content-Type': 'application/json',
      };
      final Response response = await _dio.delete(
        url,
        data: data,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
