import 'package:flutter/material.dart';
import 'package:kedis/core/widgets/my_app_bar_widget.dart';
import 'package:kedis/features/home/domain/entities/user_entity.dart';

class UserProfileScreen extends StatelessWidget {
  final UserEntity user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: MyAppBarWidget(
          nameAppBar: 'Профиль',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue.shade100,
              backgroundImage:
                  user.picture?.isNotEmpty == true
                      ? NetworkImage(user.picture!)
                      : null,
              child:
                  user.picture?.isEmpty ?? true
                      ? Text(
                        user.fullName.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontSize: 36),
                      )
                      : null,
            ),
            const SizedBox(height: 16),
            Text(
              user.fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Chip(label: Text(user.role), backgroundColor: Colors.blue.shade50),
            const SizedBox(height: 24),
            _ProfileInfoCard(user: user),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoCard extends StatelessWidget {
  final UserEntity user;

  const _ProfileInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection('Основная информация:'),
            _buildInfoRow('Группа:', user.group),
            _buildInfoRow('Специальность:', user.specialty),
            _buildInfoRow('Профессия:', user.profession),

            const SizedBox(height: 20),
            _buildSection('Контакты:'),
            _buildInfoRow('Email:', user.email),
            _buildInfoRow('Телефон:', user.phone),

            if (user.code.isNotEmpty) ...[
              const SizedBox(height: 20),
              _buildInfoRow('Код', user.code),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade800,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'Не указано',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
