import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = FlutterSecureStorage();

  Future writeKey({String? key, String? value}) async {
    var writeKey = await storage.write(key: key!, value: value);
    return writeKey;
  }

  Future readKey({String? key}) async {
    var readKey = await storage.read(key: key!);
    return readKey;
  }

  Future deleteKey({String? key}) async {
    var deleteKey = await storage.delete(key: key!);
    return deleteKey;
  }
}
