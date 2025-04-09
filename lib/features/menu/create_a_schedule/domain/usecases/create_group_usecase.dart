import 'package:kedis/features/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';

class CreateGroupUsecase {
  final CreateScheduleRepository repository;

  CreateGroupUsecase({required this.repository});

  Future<void> call(String groupId, String groupName) async {
    if (groupName.isEmpty) {
      throw Exception('Имя группы не может быть пустым');
    }
    await repository.createGroup(groupId, groupName);
  }
}
