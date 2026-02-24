import 'dart:convert';
import 'package:crypto/crypto.dart';

class BlockchainService {
  String generateBiometricHash(String prn, String mobile) {
    final bytes = utf8.encode(prn + mobile);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
