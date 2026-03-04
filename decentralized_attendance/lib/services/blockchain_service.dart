import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class BlockchainService {
  late Web3Client _client;
  late DeployedContract _contract;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;

  bool _isInitialized = false;

  BlockchainService() {
    _client = Web3Client(
      "http://192.168.31.24:7545", // Use this for Android emulator
      Client(),
    );

    _credentials = EthPrivateKey.fromHex(
      "0xdf0372d1c3a7d1fe28fb6ce13a27309c52100d9324b00535ad9a518614e71cbb",
    );
  }

  // =====================================================
  // INIT CONTRACT
  // =====================================================

  Future<void> init() async {
    if (_isInitialized) return;

    final abiString = await rootBundle.loadString("assets/educhain_abi.json");

    _contractAddress = EthereumAddress.fromHex(
      "0xc65CB0ceFFF24209942D967BCbf6677A7634E422",
    );

    _contract = DeployedContract(
      ContractAbi.fromJson(abiString, "EduChainSimple"),
      _contractAddress,
    );

    _isInitialized = true;
  }

  // =====================================================
  // REGISTER
  // =====================================================

  Future<String> registerUser({
    required String prn,
    required String mobile,
    required String name,
    required String role,
    required String department,
    required String college,
  }) async {
    await init();

    final function = _contract.function("registerUser");

    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: function,
        parameters: [prn, mobile, name, role, department, college],
        maxGas: 300000,
      ),
      chainId: 1337,
    );

    return txHash;
  }

  // =====================================================
  // LOGIN
  // =====================================================

  Future<String> loginByMobile(String mobile) async {
    await init();

    try {
      final function = _contract.function("loginByMobile");

      final result = await _client.call(
        contract: _contract,
        function: function,
        params: [mobile],
      );

      print("Blockchain login result: $result");

      if (result.isEmpty) return "";

      return result.first.toString();
    } catch (e) {
      print("LOGIN ERROR: $e");
      rethrow; // IMPORTANT
    }
  }

  // =====================================================
  // MARK ATTENDANCE
  // =====================================================

  Future<String> markAttendance(String prn) async {
    await init();

    final function = _contract.function("markAttendance");

    final txHash = await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: function,
        parameters: [prn],
        maxGas: 200000,
      ),
      chainId: 1337,
    );

    return txHash;
  }

  // =====================================================
  // VIEW ATTENDANCE
  // =====================================================

  Future<List<DateTime>> viewAttendance(String prn) async {
    await init();

    final function = _contract.function("getAttendance");

    final result = await _client.call(
      contract: _contract,
      function: function,
      params: [prn],
    );

    if (result.isEmpty) return [];

    List<dynamic> timestamps = result.first;

    return timestamps
        .map<DateTime>(
          (ts) => DateTime.fromMillisecondsSinceEpoch(
            (ts as BigInt).toInt() * 1000,
          ),
        )
        .toList();
  }
}
