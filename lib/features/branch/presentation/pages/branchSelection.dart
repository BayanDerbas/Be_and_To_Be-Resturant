import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:web_app/core/constants/app_images.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/customButton.dart';
import '../../../home/presentation/pages/home.dart';
import '../cubit/branch_cubit.dart';

class BranchSelectionPage extends StatelessWidget {
  const BranchSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.smooky,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  AppImages.logo,
                  width: 300,
                ),
              ),
              const SizedBox(height: 50),
              Text(
                'اختيار فرع المطعم',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                borderRadius: 20,
                width: 150,
                text: 'ميزيتلي',
                onPressed: () {
                  context.read<BranchCubit>().selectBranch('ميزيتلي');
                  context.go('/home');
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                borderRadius: 20,
                width: 150,
                text: 'البلدية',
                onPressed: () {
                  context.read<BranchCubit>().selectBranch('البلدية');
                  context.go('/home');
                },
              ),
        
            ],
          ),
        ),
      ),
    );
  }
}