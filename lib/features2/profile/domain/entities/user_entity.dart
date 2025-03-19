class UserEntity {
  final String email;
  final String password;
  final String id;
  final String fullName;
  final String emailUser;
  final String group;
  final String profession;
  final String phone;
  final String specialty;
  final String role;
  final String code;
  final String? picture;

  UserEntity({
    required this.email,
    required this.password,
    required this.id,
    required this.fullName,
    required this.emailUser,
    required this.group,
    required this.profession,
    required this.phone,
    required this.specialty,
    required this.role,
    required this.code,
    this.picture,
  });
}