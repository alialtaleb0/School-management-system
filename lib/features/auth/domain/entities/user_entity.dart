class UserEntity {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String phone;
  final String role;
  final String? token;
  final String? profileImage;
  final String? dateOfBirth;
  final String? studentNumber;

  UserEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.phone,
    required this.role,
    this.token,
    this.profileImage,
    this.dateOfBirth,
    this.studentNumber,
  });
}
