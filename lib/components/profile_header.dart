import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String username;
  final String profileImage;

  const ProfileHeader({
    super.key,
    required this.username,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: profileImage.startsWith('http')
                    ? NetworkImage(profileImage)
                    : AssetImage(profileImage) as ImageProvider,
              ),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("WELCOME BACK,", style: TextStyle(color: Colors.white.withOpacity(.65), fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 1, fontFamily: 'SF Pro')),
                  const SizedBox(height: 2),
                  Text(username.toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1.2, fontFamily: 'SF Pro')),
                ],
              ),
            ],
          ),
          IconButton(icon: const Icon(Icons.settings, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }
}
