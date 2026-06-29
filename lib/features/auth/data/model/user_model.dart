
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.address,
    required super.phone,
    required super.role,
    super.token,
    super.profileImage,
    super.dateOfBirth,
    super.studentNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      role: json['role'] ?? 'student',
      token: json['token'],
      profileImage: json['profile_image'],
      dateOfBirth: json['date_of_birth'],
      studentNumber: json['student_number'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'address': address,
    'phone': phone,
    'role': role,
    'token': token,
    'profile_image': profileImage,
    'date_of_birth': dateOfBirth,
    'student_number': studentNumber,
  };
}
