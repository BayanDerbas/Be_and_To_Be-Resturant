import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../branch/presentation/cubit/branch_cubit.dart';
import '../cubit/header/header_cubit.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveConfig.of(context);
    final double contentWidth = (responsive.isDesktop || responsive.isTablet) ? 1000 : MediaQuery.of(context).size.width;

    return BlocBuilder<HeaderCubit, HeaderState>(
      builder: (context, state) {
        Color headerColor = Colors.transparent;
        if (state is HeaderChanged && state.backgroundColor != Colors.transparent) {
          headerColor = AppColors.red;
        }
        return Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: contentWidth,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 100,
                color: headerColor,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => print("Cart Clicked"),
                          icon: const Icon(Icons.shopping_cart, color: AppColors.white, size: 30),
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => print("Notifications Clicked"),
                          icon: const Icon(Icons.notifications_none, color: AppColors.white, size: 30),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => print("About Clicked"),
                          child: const Text("حول", style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/branch_selection'),
                          child: Image.asset(
                            AppImages.logo_header,
                            height: responsive.isDesktop ? 210 : responsive.isTablet ? 210 : 80,
                            width: responsive.isDesktop ? 100 : responsive.isTablet ? 150 : 80,
                          ),
                        ),
                        BlocBuilder<BranchCubit, BranchState>(
                          builder: (context, state) {
                            String branchName = '.....';
                            if (state is BranchSelected) branchName = state.branchName;
                            return Text(branchName, style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold));
                          },
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () => print("Menu Clicked"),
                          icon: const Icon(Icons.menu, color: AppColors.white, size: 30),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
