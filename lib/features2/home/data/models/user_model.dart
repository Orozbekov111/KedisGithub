import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String password;
  final String fullName;
  final String emailUser;
  final String group;
  final String profession;
  final String phone;
  final String specialty;
  final String role;
  final String code;
  final String? picture;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
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

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: data['email'],
      password: data['password'],
      fullName: data['fullName'],
      emailUser: data['emailUser'],
      group: data['group'],
      profession: data['profession'],
      phone: data['phone'],
      specialty: data['specialty'],
      role: data['role'],
      code: data['code'],
      picture: data['picture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'emailUser': emailUser,
      'group': group,
      'profession': profession,
      'phone': phone,
      'specialty': specialty,
      'role': role,
      'code': code,
      'picture': picture,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      password: password,
      fullName: fullName,
      emailUser: emailUser,
      group: group,
      profession: profession,
      phone: phone,
      specialty: specialty,
      role: role,
      code: code,
      picture: picture,
    );
  }
}