import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletService {
  Future<void> connectWallet() async {
    final connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'Biometric Attendance',
        description: 'University Attendance DApp',
        url: 'https://example.com',
        icons: ['https://example.com/icon.png'],
      ),
    );

    if (!connector.connected) {
      await connector.createSession(
        chainId: 80001,
        onDisplayUri: (uri) {
          print(uri); // Open MetaMask with this URI
        },
      );
    }
  }
}
