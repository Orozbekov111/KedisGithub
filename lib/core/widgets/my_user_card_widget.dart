
import 'package:flutter/material.dart';
import 'package:kedis/features2/home/domain/entities/user_entity.dart';
import 'package:kedis/features2/home/presentation/compotent/screens/profile_screen.dart';

class MyUserCardWidget extends StatelessWidget {
  final UserEntity user;

  const MyUserCardWidget({required this.user});

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
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfileScreen(user: user),
          ),
        ),
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
                      style: TextStyle(
                        
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
      ),),
    );
  }
}


