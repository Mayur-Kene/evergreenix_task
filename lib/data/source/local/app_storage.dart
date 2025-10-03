import 'package:get_storage/get_storage.dart';

class AppStorage {
  static final _storage = GetStorage("evergreenix");

  static void logout() {
    _storage.erase();
  }

  static void setValue(String key, dynamic data) {
    _storage.write(key, data);
  }

  static dynamic valueFor(String key) {
    return _storage.read(key);
  }
}

class StorageKey {
  static String isLoggedIn = 'is_logged_in';
  static String userId = 'user_id';
  static String token = 'token';
  static String user = 'user';
  static String defaultAddress = 'default_address';
}
