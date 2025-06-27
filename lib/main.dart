import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/features/home/presentation/cubit/header/header_cubit.dart';
import 'package:web_app/features/home/presentation/cubit/scrollToTop/scroll_to_top_cubit.dart';
import 'package:web_app/features/home/presentation/cubit/urlLauncher/url_launcher_cubit.dart';
import 'config/ResponsiveUI/responsiveConfig.dart';
import 'core/routes/appRouter.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'config/theme/app_theme.dart';
import 'features/branch/presentation/cubit/branch_cubit.dart';
import 'features/home/presentation/cubit/products/products_cubit.dart';
import 'features/home/presentation/cubit/typesProduct/types_product_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => AuthCubit()),
        BlocProvider<BranchCubit>(create: (_) => BranchCubit()),
        BlocProvider<HeaderCubit>(create: (_) => HeaderCubit()),
        BlocProvider<ProductsCubit>(create: (_) => ProductsCubit()..loadProducts()),
        BlocProvider(create: (_) => ProductTypesCubit()),
        BlocProvider(create: (_) => UrlLauncherCubit()),
      ],
      child: Builder(
        builder: (context) {
          return ResponsiveConfig(
            context: context,
            child: MaterialApp.router(
              theme: AppTheme.lightTheme,
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                final responsive = ResponsiveConfig.of(context);

                if (responsive.isDesktop || responsive.isTablet) {
                  return child!;
                }

                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500,
                    ),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
