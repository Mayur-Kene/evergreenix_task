import 'package:evergreenix_task/data/source/network/api_client.dart';

class AuthRepository {
  Future<dynamic> signIn(Map<String, dynamic> body) async {
    try {
      final response = ApiClient.client.post('v1/account/signin', body);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<dynamic> signUp(Map<String, dynamic> body) async {
    try {
      final response = ApiClient.client.post('v1/account/signup', body);
      return response;
    } catch (e) {
      return Future.error(e);
    }
  }
}
