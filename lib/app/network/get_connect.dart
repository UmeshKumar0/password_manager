import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class PostsProvider extends GetConnect {
  final String _baseUrl = "http://172.16.0.201:9002/api/v1"; 
  final local = GetStorage();

  Future<Response> getCall(
    String url,
  ) async =>
      await get(_baseUrl + url,
          headers: {"authorization": "Bearer ${local.read("token")}" ?? ""});

  Future<Response> postCall(
    String url,
    Map<String, dynamic> data,
  ) async =>
      await post(_baseUrl + url, data,
          headers: {"authorization": "Bearer ${local.read("token")}" ?? ""});

  Future<Response> patchCall(
    String url,
    Map<String, dynamic> data,
  ) async =>
      await patch(_baseUrl + url, data,
          headers: {"authorization": "Bearer ${local.read("token")}" ?? ""});
  Future<Response> delCall(
    String url,
  ) async =>
      await delete(_baseUrl + url,
          headers: {"authorization": "Bearer ${local.read("token")}" ?? ""});

  Future<String> delHttpCall(String url, Map<String, dynamic> data) async {
    final request = http.Request("DELETE", Uri.parse(_baseUrl + url));
    request.headers.addAll(<String, String>{
      "authorization": "Bearer ${local.read("token")}" ?? ""
    });
    request.body = jsonEncode(data);
    final response = await request.send();
    if (response.statusCode != 200) {
      return Future.error("error: status code ${response.statusCode}");
    }
    return await response.stream.bytesToString();
  }
}
