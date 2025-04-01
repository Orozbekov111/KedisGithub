import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final String id;
  final String email;
  final String name;
  final String groupId;
  final String role;

  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.groupId,
    required this.role,
  });

  bool get hasGroup => groupId.isNotEmpty;

  @override
  List<Object?> get props => [id, email, name, groupId, role];
}