// import 'package:flutter/material.dart';

// class DashboardScreen extends StatelessWidget {
//   final String userId;
//   final String role;

//   const DashboardScreen({Key? key, required this.userId, required this.role})
//     : super(key: key);

//   final Color primaryBrown = const Color(0xFF8D6E63);
//   final Color accentOrange = const Color(0xFFFFB74D);
//   final Color backgroundColor = const Color(0xFFFDF6EC);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Column(
//         children: [
//           /// ===== HEADER =====
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [primaryBrown, primaryBrown.withOpacity(0.85)],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: const BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Welcome,",
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   userId,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   "$role Dashboard",
//                   style: TextStyle(color: Colors.white.withOpacity(0.85)),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 30),

//           /// ===== ACTION CARDS =====
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 children: [
//                   if (role == "Teacher") ...[
//                     _actionCard(
//                       icon: Icons.check_circle_outline,
//                       title: "Mark Attendance",
//                       subtitle: "Securely record attendance on blockchain",
//                     ),
//                     const SizedBox(height: 20),
//                     _actionCard(
//                       icon: Icons.bar_chart,
//                       title: "View Attendance",
//                       subtitle: "Analyze and review attendance data",
//                     ),
//                   ] else ...[
//                     _actionCard(
//                       icon: Icons.assignment_outlined,
//                       title: "View My Attendance",
//                       subtitle: "Track your academic attendance records",
//                     ),
//                   ],

//                   const Spacer(),

//                   /// Watermark Image
//                   Opacity(
//                     opacity: 0.08,
//                     child: Image.asset(
//                       "assets/images/university.png",
//                       height: 100,
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _actionCard({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//   }) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: const [
//           BoxShadow(
//             blurRadius: 12,
//             offset: Offset(0, 6),
//             color: Colors.black12,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: 28,
//             backgroundColor: accentOrange.withOpacity(0.2),
//             child: Icon(icon, color: accentOrange, size: 28),
//           ),
//           const SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(subtitle, style: const TextStyle(fontSize: 13)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final String userId;
  final String role;

  const DashboardScreen({Key? key, required this.userId, required this.role})
    : super(key: key);

  final Color primaryBrown = const Color(0xFF8D6E63);
  final Color accentOrange = const Color(0xFFFFB74D);
  final Color backgroundColor = const Color(0xFFFDF6EC);

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryBrown, primaryBrown.withOpacity(0.85)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome,",
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            userId,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "$role Dashboard",
            style: TextStyle(color: Colors.white.withOpacity(0.85)),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 6),
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: accentOrange.withOpacity(0.2),
              child: Icon(icon, color: accentOrange, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        const SizedBox(height: 30),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                if (role == "Teacher") ...[
                  _actionCard(
                    icon: Icons.check_circle_outline,
                    title: "Mark Attendance",
                    subtitle: "Securely record attendance on blockchain",
                    onTap: () {},
                  ),
                  const SizedBox(height: 20),
                  _actionCard(
                    icon: Icons.bar_chart,
                    title: "View Attendance",
                    subtitle: "Analyze and review attendance data",
                    onTap: () {},
                  ),
                ] else ...[
                  _actionCard(
                    icon: Icons.assignment_outlined,
                    title: "View My Attendance",
                    subtitle: "Track your academic attendance records",
                    onTap: () {},
                  ),
                ],
                const Spacer(),
                Opacity(
                  opacity: 0.08,
                  child: Image.asset(
                    "assets/images/university.png",
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20),
                _logoutButton(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _logoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: primaryBrown),
        ),
        alignment: Alignment.center,
        child: const Text(
          "Logout",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: Container(
          color: backgroundColor,
          child: SafeArea(child: _buildBody(context)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(child: _buildBody(context)),
    );
  }
}
