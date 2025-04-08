import 'package:kedis/features2/menu/create_a_schedule/domain/repositories/create_schedule_repository.dart';

class CreateGroupUsecase {
  final CreateScheduleRepository repository;

  CreateGroupUsecase({required this.repository});

  Future<void> call(String groupId, String groupName) async {
    if (groupName.isEmpty) {
      throw Exception('Group name cannot be empty');
    }
    await repository.createGroup(groupId, groupName);
  }
}
