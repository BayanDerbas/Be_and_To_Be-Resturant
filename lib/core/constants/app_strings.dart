import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class AppStrings {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String menu(BuildContext context) => of(context).menu;
  static String login(BuildContext context) => of(context).login;
  static String signup(BuildContext context) => of(context).signup;
  static String changeBranch(BuildContext context) => of(context).changeBranch;
  static String changeLanguage(BuildContext context) => of(context).changeLanguage;
  static String selectLanguage(BuildContext context) => of(context).selectLanguage;
  static String english(BuildContext context) => of(context).english;
  static String arabic(BuildContext context) => of(context).arabic;
  static String logout(BuildContext context) => of(context).logout;
  static String fullName(BuildContext context) => of(context).fullName;
  static String nameHint(BuildContext context) => of(context).nameHint;
  static String phoneNumber(BuildContext context) => of(context).phoneNumber;
  static String phoneHint(BuildContext context) => of(context).phoneHint;
  static String password(BuildContext context) => of(context).password;
  static String passwordHint(BuildContext context) => of(context).passwordHint;
  static String about(BuildContext context) => of(context).about;
  static String chooseBranch(BuildContext context) => of(context).chooseBranch;
  static String failedDownloadBranch(BuildContext context) => of(context).failedDownloadBranch;
}