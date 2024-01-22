

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_text_styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:  Colors.cyan,
      body: Text('profile' , style: AppTextStyles.headline1,),
    );
  }
}
