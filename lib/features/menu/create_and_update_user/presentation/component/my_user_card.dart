
import 'package:flutter/material.dart';
import 'package:kedis/features/menu/create_and_update_user/domain/entities/menu_user_entity.dart';

class MyUserCard extends StatelessWidget {
  final MenuUserEntity user;
  final VoidCallback onTap;

  const MyUserCard({
    required this.user,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildUserAvatar(),
              const SizedBox(width: 16),
              _buildUserInfo(),
              const Spacer(),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return CircleAvatar(
      radius: 24,
      backgroundColor: Colors.blue.shade100,
      backgroundImage: user.picture?.isNotEmpty == true
          ? NetworkImage(user.picture!)
          : null,
      child: user.picture?.isEmpty ?? true
          ? Text(
              user.fullName.isNotEmpty 
                  ? user.fullName.substring(0, 1).toUpperCase()
                  : '?',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            )
          : null,
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.fullName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (user.group.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            user.group,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
        if (user.email.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ],
    );
  }
}
