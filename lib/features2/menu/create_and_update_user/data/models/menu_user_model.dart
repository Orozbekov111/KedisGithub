import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/entities/menu_user_entity.dart';

class MenuUserModel extends MenuUserEntity {
  const MenuUserModel({
    required String id,
    required String email,
    required String password,
    required String fullName,
    required String emailUser,
    required String group,
    required String profession,
    required String phone,
    required String specialty,
    required String role,
    required String code,
    String? picture,
  }) : super(
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

  factory MenuUserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MenuUserModel(
      id: doc.id,
      email: data['email'] ?? '',
      password: data['password'] ?? '',
      fullName: data['fullName'] ?? '',
      emailUser: data['emailUser'] ?? '',
      group: data['group'] ?? '',
      profession: data['profession'] ?? '',
      phone: data['phone'] ?? '',
      specialty: data['specialty'] ?? '',
      role: (data['role']?.toString().toLowerCase() ?? 'user'),
      code: data['code'] ?? '',
      picture: data['picture'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      if (picture != null) 'picture': picture,
    };
  }

  MenuUserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? fullName,
    String? emailUser,
    String? group,
    String? profession,
    String? phone,
    String? specialty,
    String? role,
    String? code,
    String? picture,
  }) {
    return MenuUserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      emailUser: emailUser ?? this.emailUser,
      group: group ?? this.group,
      profession: profession ?? this.profession,
      phone: phone ?? this.phone,
      specialty: specialty ?? this.specialty,
      role: role ?? this.role,
      code: code ?? this.code,
      picture: picture ?? this.picture,
    );
  }
}
