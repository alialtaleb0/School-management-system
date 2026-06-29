import 'package:dio/dio.dart';
import 'package:school_managment_system/core/network/api_consatnt.dart';
import 'package:school_managment_system/core/storage/local_storage.dart';

class DioClient {
  late final Dio _dio;
  final LocalStorage _storage;

DioClient(this._storage) {
    _dio = Dio(BaseOptions(
      baseUrl: ApiConsatnt.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Accept': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ));
  }

  Future<Map<String,dynamic>> get(String path,{Map<String,dynamic>? queryParameters})async{
    final response =await _dio.get(path,queryParameters: queryParameters);
    return response.data;
  }

  Future<Map<String,dynamic>> post(String path,{Map<String,dynamic>? data,Map<String,dynamic>?queryParameters})async{
    final response =await _dio.post(path,queryParameters: queryParameters,data: data);
    return response.data;
  }

Future<Map<String,dynamic>> put(String path,{Map<String,dynamic>? data})async{
    final response =await _dio.put(path,data: data);
    return response.data;
  }

Future<Map<String,dynamic>> delete(String path)async{
    final response =await _dio.put(path);
    return response.data;
  }

Future<Map<String,dynamic>> UplodaeFile(String path,{required Map<String,dynamic>fileds,List<MapEntry<String,String>>? files})async{
  final formData =FormData();
  fileds.forEach((key,value){
    formData.fields.add(MapEntry(key, value.toString()));
  });
  if (files != null){
    for (final entry in files){
      formData.files.add(MapEntry(entry.key,await MultipartFile.fromFile(entry.value)));
    }
  }
  final response = await _dio.post(path,data: formData);
  return response.data;
}

}