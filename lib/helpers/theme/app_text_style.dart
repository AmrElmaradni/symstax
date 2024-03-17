import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle(TextStyle textD14R);

  static TextStyle appBarStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: AppColor.appBarTextColor(context, listen: listen),
      fontFamily: context.fontFamily(),
    );
  }

  static TextStyle buttonStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: AppColor.buttonTextColor(context, listen: listen),
    );
  }

  static TextStyle hintStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.hintColor(context, listen: listen),
    );
  }

  static TextStyle textFormStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColor.textFormColor(context, listen: listen),
    );
  }

  static TextStyle formTitleStyle(BuildContext context, {bool listen = true}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text22B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text20B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text18B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text16B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text14B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text12B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text10B(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text18M(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text16M(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text14M(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text12M(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text10M(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text18R(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text16R(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text14R(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text12R(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }

  static TextStyle text10R(BuildContext context,
      {bool listen = true, Color? color}) {
    return TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: color ?? AppColor.darkTextColor(context, listen: listen),
    );
  }
}
