// import 'package:flutter/material.dart';
// import '../services/biometric_service.dart';
// import '../services/blockchain_service.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();

//   final TextEditingController _idController = TextEditingController();
//   final TextEditingController _mobileController = TextEditingController();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _departmentController = TextEditingController();
//   final TextEditingController _collegeController = TextEditingController();

//   String _selectedRole = "Student";
//   bool _isLoading = false;

//   final Color primaryBrown = const Color(0xFF6D4C41);
//   final Color accentOrange = const Color(0xFFFFA726);

//   @override
//   void dispose() {
//     _idController.dispose();
//     _mobileController.dispose();
//     _nameController.dispose();
//     _departmentController.dispose();
//     _collegeController.dispose();
//     super.dispose();
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white.withOpacity(0.95),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(16),
//         borderSide: BorderSide(color: accentOrange, width: 2),
//       ),
//     );
//   }

//   Future<void> _registerUser() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);

//     try {
//       bool isAuthenticated = await BiometricService().authenticate();

//       if (!isAuthenticated) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Biometric Authentication Failed")),
//         );
//         setState(() => _isLoading = false);
//         return;
//       }

//       String hash = BlockchainService().generateBiometricHash(
//         _idController.text.trim(),
//         _mobileController.text.trim(),
//       );

//       print("Generated Hash: $hash");

//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("Registration Successful")));

//       _formKey.currentState!.reset();
//     } catch (e) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(SnackBar(content: Text("Error: $e")));
//     }

//     setState(() => _isLoading = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox.expand(
//         child: Stack(
//           children: [
//             /// Background Image
//             Positioned.fill(
//               child: Image.asset(
//                 "assets/images/university.png",
//                 fit: BoxFit.cover,
//               ),
//             ),

//             /// White Fade Overlay
//             Positioned.fill(
//               child: Container(color: Colors.white.withOpacity(0.90)),
//             ),

//             /// Content
//             SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: MediaQuery.of(context).size.height,
//                 ),
//                 child: IntrinsicHeight(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       /// 🔵 Rounded Logo (Like Login)
//                       Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           boxShadow: [
//                             BoxShadow(
//                               color: accentOrange.withOpacity(0.3),
//                               blurRadius: 25,
//                               spreadRadius: 4,
//                             ),
//                           ],
//                         ),
//                         child: const CircleAvatar(
//                           radius: 55,
//                           backgroundImage: AssetImage(
//                             "assets/images/blockchain.png",
//                           ),
//                           backgroundColor: Colors.white,
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       const Text(
//                         "EduChain Registration",
//                         style: TextStyle(
//                           fontSize: 26,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 24),
//                         child: Container(
//                           padding: const EdgeInsets.all(22),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.95),
//                             borderRadius: BorderRadius.circular(24),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.12),
//                                 blurRadius: 30,
//                                 offset: const Offset(0, 15),
//                               ),
//                             ],
//                           ),
//                           child: Form(
//                             key: _formKey,
//                             child: Column(
//                               children: [
//                                 DropdownButtonFormField<String>(
//                                   value: _selectedRole,
//                                   decoration: _inputDecoration("Select Role"),
//                                   items: ["Student", "Teacher"]
//                                       .map(
//                                         (role) => DropdownMenuItem(
//                                           value: role,
//                                           child: Text(role),
//                                         ),
//                                       )
//                                       .toList(),
//                                   onChanged: (value) =>
//                                       setState(() => _selectedRole = value!),
//                                 ),

//                                 const SizedBox(height: 18),

//                                 TextFormField(
//                                   controller: _idController,
//                                   decoration: _inputDecoration(
//                                     _selectedRole == "Student"
//                                         ? "PRN Number"
//                                         : "Employee ID",
//                                   ),
//                                 ),

//                                 const SizedBox(height: 18),

//                                 TextFormField(
//                                   controller: _mobileController,
//                                   keyboardType: TextInputType.phone,
//                                   decoration: _inputDecoration("Mobile Number"),
//                                 ),

//                                 const SizedBox(height: 18),

//                                 TextFormField(
//                                   controller: _nameController,
//                                   decoration: _inputDecoration("Full Name"),
//                                 ),

//                                 const SizedBox(height: 18),

//                                 TextFormField(
//                                   controller: _departmentController,
//                                   decoration: _inputDecoration("Department"),
//                                 ),

//                                 const SizedBox(height: 18),

//                                 TextFormField(
//                                   controller: _collegeController,
//                                   decoration: _inputDecoration("College Name"),
//                                 ),

//                                 const SizedBox(height: 30),

//                                 GestureDetector(
//                                   onTap: _isLoading ? null : _registerUser,
//                                   child: Container(
//                                     height: 55,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       gradient: LinearGradient(
//                                         colors: [accentOrange, primaryBrown],
//                                       ),
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     alignment: Alignment.center,
//                                     child: _isLoading
//                                         ? const CircularProgressIndicator(
//                                             color: Colors.white,
//                                           )
//                                         : const Text(
//                                             "Register with Biometric",
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../services/biometric_service.dart';
import '../services/blockchain_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();

  String _selectedRole = "Student";
  bool _isLoading = false;

  final Color primaryBrown = const Color(0xFF6D4C41);
  final Color accentOrange = const Color(0xFFFFA726);

  @override
  void dispose() {
    _idController.dispose();
    _mobileController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
    _collegeController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white.withOpacity(0.95),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: accentOrange, width: 2),
      ),
    );
  }

  void _showMessage(String message) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          title: const Text("Notice"),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      bool isAuthenticated = await BiometricService().authenticate();

      if (!isAuthenticated) {
        _showMessage("Biometric Authentication Failed");
        setState(() => _isLoading = false);
        return;
      }

      String hash = BlockchainService().generateBiometricHash(
        _idController.text.trim(),
        _mobileController.text.trim(),
      );

      print("Generated Hash: $hash");

      _showMessage("Registration Successful");

      _formKey.currentState!.reset();
      _idController.clear();
      _mobileController.clear();
      _nameController.clear();
      _departmentController.clear();
      _collegeController.clear();
    } catch (e) {
      _showMessage("Error: $e");
    }

    setState(() => _isLoading = false);
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  "assets/images/university.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Container(color: Colors.white.withOpacity(0.90)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: accentOrange.withOpacity(0.3),
                          blurRadius: 25,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage: AssetImage(
                        "assets/images/blockchain.png",
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "EduChain Registration",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              decoration: _inputDecoration("Select Role"),
                              items: ["Student", "Teacher"]
                                  .map(
                                    (role) => DropdownMenuItem(
                                      value: role,
                                      child: Text(role),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) =>
                                  setState(() => _selectedRole = value!),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _idController,
                              decoration: _inputDecoration(
                                _selectedRole == "Student"
                                    ? "PRN Number"
                                    : "Employee ID",
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? "This field is required"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              decoration: _inputDecoration("Mobile Number"),
                              validator: (value) =>
                                  value == null || value.length != 10
                                  ? "Enter valid 10-digit mobile"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _nameController,
                              decoration: _inputDecoration("Full Name"),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? "Enter your name"
                                  : null,
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _departmentController,
                              decoration: _inputDecoration("Department"),
                            ),
                            const SizedBox(height: 18),
                            TextFormField(
                              controller: _collegeController,
                              decoration: _inputDecoration("College Name"),
                            ),
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: _isLoading ? null : _registerUser,
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [accentOrange, primaryBrown],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                alignment: Alignment.center,
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Register with Biometric",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(child: _buildBody())
        : Scaffold(body: _buildBody());
  }
}
