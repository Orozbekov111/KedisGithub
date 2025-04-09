import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kedis/features/menu/create_a_schedule/domain/usecases/create_group_usecase.dart';
import 'package:kedis/features/menu/create_a_schedule/presentation/bloc/group/create_group_bloc.dart';
import 'package:kedis/features/menu/create_a_schedule/presentation/component/create_group_form.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              CreateGroupBloc(createGroup: context.read<CreateGroupUsecase>()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Group')),
        body: const CreateGroupForm(),
      ),
    );
  }
}
