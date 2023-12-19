import 'package:dio/dio.dart' as dio;

abstract class IHttpClient {
  Future post({required String url,required Map<String, String> data});
}

class DioClient implements IHttpClient {
  @override
  Future post({required String url, required Map<String, String> data}) async {
    final client = dio.Dio();

    return await client.post(url , data: data, options: dio.Options(
      method: "POST",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      }
      ));
  }
}
