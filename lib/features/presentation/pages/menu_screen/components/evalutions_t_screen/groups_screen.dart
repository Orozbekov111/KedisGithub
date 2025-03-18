
import 'package:flutter/material.dart';

import '../../../../../data/models/group_model.dart';
import '../../../../../data/repositories/GroupRepository.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import 'course_selection_screen.dart';

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  final GroupRepository _groupRepository = GroupRepository();

  Future<List<GroupModel>> getAllGroups() async {
    return await _groupRepository.getAllGroups();
  }

  void navigateToCourseSelection(String groupName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseSelectionScreen(groupName: groupName),
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Группы',
        ),
      ),
      body: FutureBuilder<List<GroupModel>>(
        future: getAllGroups(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка при получении групп'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных групп.'));
          }

          final groups = snapshot.data!;
          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ButtonWidget(
                text: '${group.groupName}',
                pressed: () => navigateToCourseSelection(group.groupName),
              );
            },
          );
        },
      ),
    );
  }
}