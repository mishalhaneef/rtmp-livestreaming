import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livestream/configs/api_end_points.dart';

class BaseApiService {
  final dio = Dio();

  Future<Response?> patchApiCall(
    String apiUrl, {
    dynamic body,
    String? contentType,
  }) async {
    try {
      Response response = await dio.patch(
        ApiEndPoints.baseUrl + apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: body,
      );
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
      }
      log('Patch Request Error: $e');
      return null;
    }
  }

  Future<Response?> getApiCall(
    String firebaseToken,
    String apiUrl, {
    dynamic body,
    String? contentType,
    // Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.get(ApiEndPoints.baseUrl + apiUrl);
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
      }
      log('Get Request Error: $e');
      return null;
    }
  }

  Future<Response?> postApiCall(
    String apiUrl, {
    dynamic body,
    String? contentType,
  }) async {
    try {
      log('api : ${ApiEndPoints.baseUrl + apiUrl}');
      dio.options.headers = {'Content-Type': 'application/json'};
      Response response =
          await dio.post(ApiEndPoints.baseUrl + apiUrl, data: body);
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
      }
      log('Post Request Error: $e');
      return null;
    }
  }

  Future<Response?> avatarUploadApiCall(
    String apiUrl, {
    dynamic body,
    String? contentType,
    XFile? imageXfile,
  }) async {
    try {
      FormData formData = FormData();
      formData.files.add(
        MapEntry(
          'profile.avatar',
          await MultipartFile.fromFile(
            imageXfile!.path,
            filename: imageXfile.name,
          ),
        ),
      );
      (body as Map<String, dynamic>).forEach(
        (key, value) => formData.fields.add(
          MapEntry<String, String>(key, value.toString()),
        ),
      );
      Response response = await dio.patch(
        ApiEndPoints.baseUrl + apiUrl,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
        data: formData,
      );
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
      }
      log('Patch Request Error: $e');
      return null;
    }
  }

  Future<Response?> putApiCall(
    String apiUrl, {
    dynamic body,
    String? contentType,
  }) async {
    try {
      Response response = await dio.put(
        ApiEndPoints.baseUrl + apiUrl,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
        data: body,
      );
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
        log("ERROR : ${e.response!.data}");
        log("ERROR : ${e.response!.headers}");
        log("ERROR : ${e.message}");
      } else {
        log('PUT Request Error: $e');
      }
      return null;
    }
  }

  Future<Response?> deleteApiCall(String firebaseToken, String apiUrl) async {
    try {
      log(ApiEndPoints.baseUrl + apiUrl);
      Response response = await dio.delete(ApiEndPoints.baseUrl + apiUrl);
      logApiResponse(response);
      return response;
    } catch (e) {
      if (e is DioException) {
        _handleApiError(e);
      }
      log('Delete Request Error: $e');
      return null;
    }
  }
}

void _handleApiError(DioException error) {
  if (error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.type == DioExceptionType.sendTimeout) {
    Fluttertoast.showToast(msg: "No Internet Connection");
  }
  log('Request Error: $error');
}

logApiResponse(Response response) {
  log('Response statuscode : ${response.statusCode}');
  log('request option : ${response.requestOptions.data}');
  log('Response data: ${response.data}');
}
