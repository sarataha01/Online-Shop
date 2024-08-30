import 'package:flutter/material.dart';

import '../pages/profile_screen.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      icon: const Icon(Icons.person),
      splashRadius: 15,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyProfile(),
          ),
        );
      },
    );
  }
}
