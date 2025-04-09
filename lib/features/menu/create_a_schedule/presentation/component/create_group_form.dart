import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features/menu/create_a_schedule/presentation/bloc/group/create_group_bloc.dart';
import 'package:kedis/features/menu/create_a_schedule/presentation/pages/select_day_page.dart';

class CreateGroupForm extends StatefulWidget {
  const CreateGroupForm({Key? key}) : super(key: key);

  @override
  _CreateGroupFormState createState() => _CreateGroupFormState();
}

class _CreateGroupFormState extends State<CreateGroupForm> {
  final _formKey = GlobalKey<FormState>();
  final _groupNameController = TextEditingController();

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupBloc, GroupState>(
      listener: (context, state) {
        if (state is GroupCreated) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SelectDayPage(groupId: state.groupId),
            ),
          );
        } else if (state is GroupError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
              validator:
                  (value) =>
                      value?.isEmpty ?? true ? 'Please enter group name' : null,
            ),
            const SizedBox(height: 20),
            BlocBuilder<CreateGroupBloc, GroupState>(
              builder: (context, state) {
                if (state is GroupLoading) {
                  return const CircularProgressIndicator();
                }
                return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<CreateGroupBloc>().add(
                        CreateGroupEvent(_groupNameController.text),
                      );
                    }
                  },
                  child: const Text('Create Group'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
