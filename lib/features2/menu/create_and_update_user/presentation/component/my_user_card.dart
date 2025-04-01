
import 'package:flutter/material.dart';
import 'package:kedis/features2/menu/create_and_update_user/domain/entities/menu_user_entity.dart';
import 'package:kedis/features2/menu/create_and_update_user/presentation/pages/update_screens/user_profile_screen.dart';
class MyUserCard extends StatelessWidget {
  final MenuUserEntity user;
  final VoidCallback onTap;  // Changed from Widget to VoidCallback

  const MyUserCard({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF00796B), Color(0xFF004D40)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,  // Now correctly using the callback
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  backgroundImage: user.picture?.isNotEmpty == true
                      ? NetworkImage(user.picture!)
                      : null,
                  child: user.picture?.isEmpty ?? true
                      ? Text(user.fullName.substring(0, 1).toUpperCase())
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.group,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: Colors.grey.shade400),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
