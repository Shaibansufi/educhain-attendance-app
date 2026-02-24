import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Authenticate user using biometrics
  Future<bool> authenticate() async {
    try {
      // 1️⃣ Check if device supports biometrics
      bool canCheck = await _auth.canCheckBiometrics;
      bool isDeviceSupported = await _auth.isDeviceSupported();
      if (!canCheck || !isDeviceSupported) {
        print("Biometric not available");
        return false;
      }

      // 2️⃣ Get available biometric types (optional)
      List<BiometricType> availableBiometrics = await _auth
          .getAvailableBiometrics();
      print("Available Biometrics: $availableBiometrics");

      // 3️⃣ Authenticate
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Authenticate to proceed',
        options: const AuthenticationOptions(
          biometricOnly: true, // Use only biometrics (no device PIN)
          stickyAuth: true, // Keeps auth alive if app goes background
          useErrorDialogs: true, // Shows system error dialogs
        ),
      );

      return authenticated;
    } catch (e) {
      print("Biometric authentication error: $e");
      return false;
    }
  }
}
