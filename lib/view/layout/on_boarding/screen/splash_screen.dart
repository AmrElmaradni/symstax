import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_text_style.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../auth/screen/login_screen.dart';
import '../../event/screen/events_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = 'SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      _firebaseAuth.currentUser != null
          ? NavigatorMethods.pushNamedAndRemoveUntil(
              context,
              EventsScreen.routeName,
            )
          : NavigatorMethods.pushNamedAndRemoveUntil(
              context,
              LoginScreen.routeName,
            );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      statusBarColor: AppColor.mainAppColor(context),
      child: Scaffold(
        backgroundColor: AppColor.mainAppColor(context),
        body: Center(
          child: Text(
            "LOGO",
            style: AppTextStyle.text22B(context),
          ),
        ),
      ),
    );
  }
}
