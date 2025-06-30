import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubit/locale/locale_cubit.dart';

class CustomDrawer extends StatelessWidget {
  final bool isLoggedIn;
  final VoidCallback? onLogout;

  const CustomDrawer({
    super.key,
    this.isLoggedIn = false,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black2,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.smooky,
            ),
            child: Center(
              child: Text(
                "القائمة",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login, color: AppColors.white),
              title: Text(
                "تسجيل الدخول",
                style: TextStyle(color: AppColors.white),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                Navigator.pop(context);
                context.go('/login_signup');
              },
            ),

          ListTile(
            leading: const Icon(Icons.store_mall_directory, color: AppColors.white),
            title: Text(
              "اختيار فرع",
              style: TextStyle(color: AppColors.white),
              textDirection: TextDirection.rtl,
            ),
            onTap: () {
              Navigator.pop(context);
              context.go('/branch_selection');
            },
          ),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.white),
              title: Text(
                "تسجيل الخروج",
                style: TextStyle(color: AppColors.white),
                textDirection: TextDirection.rtl,
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                if (onLogout != null) {
                  onLogout!();
                }
              },
            ),
        ],
      ),
    );
  }
}