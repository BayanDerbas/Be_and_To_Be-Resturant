import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/customBackButton.dart';
import '../../../../core/widgets/customButton.dart';
import '../../../../core/widgets/customTextField.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class Login_SignupPage extends StatelessWidget {
  Login_SignupPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.smooky,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final bool isLogin = state is AuthLoginState;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'assets/images/alhomsi.png',
                                width: 300,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              height :50,
                              decoration: BoxDecoration(
                                color: AppColors.black2,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => context.read<AuthCubit>().showLogin(),
                                      style: TextButton.styleFrom(
                                        backgroundColor: isLogin ? AppColors.amber : AppColors.DarkOlive,
                                        minimumSize: const Size(double.infinity, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'تسجيل الدخول',
                                        style: TextStyle(
                                          color: isLogin ? AppColors.black1 : AppColors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () => context.read<AuthCubit>().showRegister(),
                                      style: TextButton.styleFrom(
                                        backgroundColor: isLogin ? AppColors.DarkOlive : AppColors.amber,
                                        minimumSize: const Size(double.infinity, 60),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Text(
                                        'حساب جديد',
                                        style: TextStyle(
                                          color: isLogin ? AppColors.white : AppColors.black1,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'الاسم الكامل',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'xxxxxx xxxxx',
                              prefixIcon: Icons.person,
                              controller: nameController,
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'رقم الهاتف',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: '(5xx) xxx-xxx',
                              prefixIcon: Icons.phone,
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(height: 40),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: CustomButton(
                                text: isLogin ? 'تسجيل الدخول' : 'حساب جديد',
                                onPressed: () {
                                  print("clicked button");
                                },
                                buttonColor: AppColors.amber,
                                textColor: AppColors.black1,
                                borderRadius: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              CustomBackButton()
            ],
          ),
        ),
      ),
    );
  }

}