import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../../helpers/locale/app_locale_key.dart';
import '../../../../helpers/theme/app_colors.dart';
import '../../../../helpers/theme/app_text_style.dart';
import '../../../../helpers/theme/app_theme_controller.dart';
import '../../../../helpers/theme/theme_enum.dart';
import '../../../../helpers/utils/navigator_methods.dart';
import '../../../custom_widgets/buttons/custom_button.dart';
import '../../../custom_widgets/custom_app_bar/custom_app_bar.dart';
import '../../../custom_widgets/custom_form_field/custom_form_field.dart';
import '../../../custom_widgets/page_container/page_container.dart';
import '../../../custom_widgets/validation/validation_mixin.dart';
import '../../event/screen/events_screen.dart';
import '../controller/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = 'LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: Scaffold(
        appBar: CustomAppBar(
          context,
          title: Text(
            tr(AppLocaleKey.signIn),
          ),
          actions: [
            IconButton(
              onPressed: () {
                if (context.read<AppThemeController>().theme ==
                    ThemeEnum.light) {
                  context.read<AppThemeController>().theme = ThemeEnum.dark;
                } else {
                  context.read<AppThemeController>().theme = ThemeEnum.light;
                }
              },
              icon: Icon(
                context.read<AppThemeController>().theme == ThemeEnum.light
                    ? CupertinoIcons.moon_fill
                    : CupertinoIcons.sun_min_fill,
                color: AppColor.appBarTextColor(context),
              ),
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    "LOGO",
                    style: AppTextStyle.text22B(context),
                  ),
                  const Gap(40),
                  CustomFormField(
                    controller: _emailEC,
                    hintText: tr(AppLocaleKey.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  const Gap(15),
                  CustomFormField(
                    controller: _passwordEC,
                    hintText: tr(AppLocaleKey.password),
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: true,
                    validator: validatePassword,
                  ),
                  const Gap(20),
                  CustomButton(
                    text: tr(AppLocaleKey.signIn),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthController>().login(
                              email: _emailEC.text,
                              password: _passwordEC.text,
                              onSuccess: () {
                                NavigatorMethods.pushNamedAndRemoveUntil(
                                  context,
                                  EventsScreen.routeName,
                                );
                              },
                            );
                      }
                    },
                  ),
                  const Gap(30),
                  TextButton(
                    onPressed: () {
                      NavigatorMethods.pushNamed(
                        context,
                        RegisterScreen.routeName,
                      );
                    },
                    child: Text(
                      tr(AppLocaleKey.singUp),
                      style: AppTextStyle.text16B(
                        context,
                        color: AppColor.mainAppColor(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
