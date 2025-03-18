
class UserModel {
  final String email; // Электронная почта пользователя
  final String password; // Пароль пользователя
  final String id; // Уникальный идентификатор пользователя
  final String fullName; // Полное имя пользователя
  final String emailUser; // Дополнительная электронная почта
  final String group; // Группа пользователя
  final String profession; // Профессия пользователя
  final String phone; // Номер телефона пользователя
  final String specialty; // Специальность пользователя
  final String role; // Роль пользователя
  final String code; // Код пользователя
  String? picture; // URL фотографии пользователя (может быть null)

  UserModel({
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

  /// Преобразует объект в JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password, // Будьте осторожны с выводом пароля!
      'id': id,
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

  /// Создает объект UserModel из JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      emailUser: json['emailUser'] as String? ?? '',
      group: json['group'] as String? ?? '',
      profession: json['profession'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      specialty: json['specialty'] as String? ?? '',
      role: json['role'] as String? ?? '',
      code: json['code'] as String? ?? '',
      picture: json['picture'] as String?,
    );
  }

  get uid => null;

  @override
  String toString() {
    return '''UserModel {
      email: $email
      password: [hidden]   // Будьте осторожны с выводом пароля!
      id: $id
      fullName: $fullName
      emailUser: $emailUser  
      group: $group
      profession: $profession
      phone: $phone
      specialty: $specialty
      role: $role
      code: $code
      picture: $picture         
    }''';
  }
  UserModel copyWith({
    String? email,
    String? password,
    String? id,
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
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      id: id ?? this.id,
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

