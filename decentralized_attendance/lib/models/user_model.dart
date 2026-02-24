class UserModel {
  final String universityId; // PRN or Employee ID
  final String role; // Student / Teacher
  final String mobile;
  final String name;
  final String department;
  final String college;
  final String walletAddress;

  UserModel({
    required this.universityId,
    required this.role,
    required this.mobile,
    required this.name,
    required this.department,
    required this.college,
    required this.walletAddress,
  });
}
