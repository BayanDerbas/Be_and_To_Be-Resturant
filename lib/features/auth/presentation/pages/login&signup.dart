import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/core/constants/app_strings.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/widgets/customBackButton.dart';
import '../../../../core/widgets/customButton.dart';
import '../../../../core/widgets/customTextField.dart';
import '../cubit/auth_cubit.dart';

class Login_SignupPage extends StatelessWidget {
  Login_SignupPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> _obscurePasswordNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig.of(context);
    double containerWidth = responsive.isMobile ? double.infinity : 550;
    return Material(
      color: AppColors.smooky2,
      child: Center(
        child: Container(
          width: containerWidth,
          height: 750,
          decoration: BoxDecoration(
            color: AppColors.smooky,
          ),
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    final bool isLogin = state is AuthLoginState;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: Image.asset(AppImages.logo, width: 200),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 40,
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
                                    minimumSize: const Size(double.infinity, 65),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.login(context),
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
                                    minimumSize: const Size(double.infinity, 65),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.signup(context),
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
                        const SizedBox(height: 20),
                        if (!isLogin) ...[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              AppStrings.fullName(context),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            hintText: AppStrings.nameHint(context),
                            prefixIcon: Icons.person,
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                        ],
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppStrings.phoneNumber(context),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: AppStrings.phoneHint(context),
                          prefixIcon: Icons.phone,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            AppStrings.password(context),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ValueListenableBuilder<bool>(
                          valueListenable: _obscurePasswordNotifier,
                          builder: (context, obscureText, child) {
                            return CustomTextField(
                              hintText: AppStrings.passwordHint(context),
                              prefixIcon: Icons.lock,
                              controller: passwordController,
                              obscureText: obscureText,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscureText ? Icons.visibility_off : Icons.visibility,
                                  color: AppColors.amber,
                                ),
                                onPressed: () {
                                  _obscurePasswordNotifier.value = !_obscurePasswordNotifier.value;
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: containerWidth,
                          height: 45,
                          child: CustomButton(
                            text: isLogin ? AppStrings.login(context) : AppStrings.signup(context),
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.go('/branch_selection');
                            },
                            buttonColor: AppColors.amber,
                            textColor: AppColors.black1,
                            borderRadius: 8,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              CustomBackButton(
                  onTap: () =>
                  context.go('/home')
              ),
            ],
          ),
        ),
      ),
    );
  }
}