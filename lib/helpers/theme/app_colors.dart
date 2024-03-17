import 'package:flutter/material.dart';

import 'app_theme.dart';

class AppColor {
  static Color mainAppColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffED2647),
      dark: const Color(0xffED2647),
      listen: listen,
    );
  }

  static Color secondAppColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff2D2D2D),
      dark: const Color(0xffababab),
      listen: listen,
    );
  }

  static Color appBarColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff1D1D1E),
      listen: listen,
    );
  }

  static Color borderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffE8ECF4),
      dark: const Color(0xff454649),
      listen: listen,
    );
  }

  static Color textFormBorderColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffE8ECF4),
      dark: const Color(0xff454649),
      listen: listen,
    );
  }

  static Color scaffoldColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff1D1D1E),
      listen: listen,
    );
  }

  static Color hintColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff8391A1),
      dark: const Color(0xffe6e9ec),
      listen: listen,
    );
  }

  static Color darkTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff000000),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color lightTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff787878),
      dark: const Color(0xffc9c9c9),
      listen: listen,
    );
  }

  static Color pinkColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFCE4C4C),
      dark: const Color(0xFFCE4C4C),
      listen: listen,
    );
  }

  static Color greyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffBCBCBC),
      dark: const Color(0xffBCBCBC),
      listen: listen,
    );
  }

  static Color darkGreyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff828282),
      dark: const Color(0xff828282),
      listen: listen,
    );
  }

  static Color lightGreyColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff7D7D7D),
      dark: const Color(0xff7D7D7D),
      listen: listen,
    );
  }

  static Color redColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffE80000),
      dark: const Color(0xffE80000),
      listen: listen,
    );
  }

  static Color greenColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff0BDA51),
      dark: const Color(0xff0BDA51),
      listen: listen,
    );
  }

  static Color blackColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff000000),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color whiteColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff000000),
      listen: listen,
    );
  }

  static Color offWhiteColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFAFAFA),
      dark: const Color(0xff191919),
      listen: listen,
    );
  }

  static Color textFormFillColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFAFAFA),
      dark: const Color(0xff191919),
      listen: listen,
    );
  }

  static Color yellowColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffFFCC00),
      dark: const Color(0xffFFCC00),
      listen: listen,
    );
  }

  static Color blueColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff007FB1),
      dark: const Color(0xff007FB1),
      listen: listen,
    );
  }

  static Color textFormColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff7D7D7D),
      dark: const Color(0xffe5e5e5),
      listen: listen,
    );
  }

  static Color bottomSheetColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff333333),
      listen: listen,
    );
  }

  static Color appBarTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xff000000),
      dark: const Color(0xffffffff),
      listen: listen,
    );
  }

  static Color buttonTextColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff000000),
      listen: listen,
    );
  }

  static Color inActiveColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xFFBDBDBD),
      dark: const Color(0xFFBDBDBD),
      listen: listen,
    );
  }

  static Color popupColor(BuildContext context, {bool listen = true}) {
    return AppTheme.getByTheme(
      context,
      light: const Color(0xffffffff),
      dark: const Color(0xff000000),
      listen: listen,
    );
  }
}
