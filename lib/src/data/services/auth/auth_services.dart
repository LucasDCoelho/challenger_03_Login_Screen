import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:project_3/src/data/http/http_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthService {
  Future<String?> login({ required String username, required String password});
  Future<void> logout();
  Future<String?> getToken();
  bool isTokenValid({ required String token });
}


class AuthService implements IAuthService {
  final String url = "https://dummyjson.com";
  final DioClient _client = DioClient();

  @override
  // Login method
  Future<String?> login({ required String username, required String password}) async {
    try{
      final response = await _client.post(
        url: "$url/auth/login", 
        data: {
          "username": username, 
          "password": password
        },
      );
      print("response $response");

      if(response.statusCode == 200){
        final Map<String, dynamic> responseData = response.data;
        final String token = responseData["token"];

        await _saveToken(token);
        print(token);
       
        return token;
      } else {
        return null;
      }
    } catch (error){
      return null;
    }
  }

  @override
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
  
  @override
  bool isTokenValid({ required String token }){
    return JwtDecoder.isExpired(token);
  }
  
  @override
  Future<bool> logout() async {
    await _clearToken();
    return false;
  }

  Future<void> _saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
  
  Future<void> _clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("limpou");
    prefs.remove("token");
  }


}