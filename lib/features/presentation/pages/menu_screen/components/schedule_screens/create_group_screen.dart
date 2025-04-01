import 'package:flutter/material.dart';

import '../../../../../data/repositories/schedule_manager_repositories.dart';
import '../../../widgets/app_bar_widget.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/textfield.dart';
import 'select_day_screen.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _groupNameController = TextEditingController();
  final ScheduleManager _scheduleManager = ScheduleManager();

  void _createGroup() async {
    String groupName = _groupNameController.text;
    if (groupName.isNotEmpty) {
      String groupId = DateTime.now().millisecondsSinceEpoch.toString();
      await _scheduleManager.createGroup(groupId, groupName);

      // Переход на экран выбора дня недели
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectDayScreen(groupName: groupId)),
      );

      // Очистка поля ввода
      _groupNameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70.0), // Высота AppBar
        child: AppBarWidget(
          nameAppBar: 'Создайте группу',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( 
          children: [
            MyTextField(
              controller: _groupNameController,
              hintText: 'Название группы',
              obscureText: false,
              keyboardType: TextInputType.name,
              prefixIcon: const Icon(Icons.lock),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'Заполните это поле';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ButtonWidget(
                text: 'Создать расписание',
                pressed: _createGroup),
          ],
        ),
      ),
    );
  }
}








