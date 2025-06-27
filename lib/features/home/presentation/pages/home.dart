import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_app/core/constants/app_images.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../cubit/header/header_cubit.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/scrollToTop/scroll_to_top_cubit.dart';
import '../cubit/typesProduct/types_product_cubit.dart';
import '../cubit/urlLauncher/url_launcher_cubit.dart';
import '../widgets/CustomBanner.dart';
import '../widgets/CustomFooter.dart';
import '../widgets/CustomHeader.dart';
import '../widgets/CustomListTypesProduct.dart';
import '../widgets/CustomMenu.dart';
import '../widgets/CustomMenuTitle.dart';
import '../widgets/CustomProductCarousel.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final headerCubit = context.read<HeaderCubit>();
    final productsCubit = context.read<ProductsCubit>();
    final productTypesCubit = context.read<ProductTypesCubit>();
    final responsive = ResponsiveConfig.of(context);

    double contentWidth = (responsive.isDesktop || responsive.isTablet)
        ? 800
        : MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productsState = productsCubit.state;
      if (productsState is ProductsLoaded) {
        final productName = productsState.products[productsState.selectedIndex]['name']!;
        productTypesCubit.loadTypesForProduct(productName);
      }
    });

    return BlocProvider(
      create: (_) => ScrollToTopCubit(headerCubit.scrollController),
      child: Scaffold(
        backgroundColor: AppColors.smooky,
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            headerCubit.changeHeaderColor(scrollNotification.metrics.pixels);
            return true;
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: headerCubit.scrollController,
                child: Column(
                  children: [
                    CustomBanner(),
                    SizedBox(height: responsive.isMobile ? 5 : 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: SizedBox(
                        width: contentWidth,
                        child: Column(
                          children: [
                            const Menu(),
                            if (responsive.isMobile) CustomMenuTitle(),
                            const SizedBox(height: 3),
                            BlocListener<ProductsCubit, ProductsState>(
                              listener: (context, state) {
                                if (state is ProductsLoaded) {
                                  final productName = state.products[state.selectedIndex]['name']!;
                                  productTypesCubit.loadTypesForProduct(productName);
                                }
                              },
                              child: BlocBuilder<ProductsCubit, ProductsState>(
                                builder: (context, state) {
                                  if (state is ProductsLoaded) {
                                    return CustomProductCarousel(
                                      products: state.products,
                                      selectedIndex: state.selectedIndex,
                                      onItemSelected: (index) {
                                        productsCubit.changeSelectedIndex(index);
                                        final productName = state.products[index]['name']!;
                                        productTypesCubit.loadTypesForProduct(productName);
                                      },
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<ProductTypesCubit, ProductTypesState>(
                      builder: (context, state) {
                        if (state is ProductTypesLoaded) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CustomListTypesProductList(
                              types: state.types,
                              contentWidth: contentWidth,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 45),
                    CustomFooter(
                      phoneNumbers: ['05050530004', '05322277790', '05333388830'],
                      logoAsset: AppImages.logo_header,
                      facebookUrl: 'https://facebook.com/alhomsi',
                      instagramUrl: 'https://instagram.com/alhomsi',
                      mapsUrl: 'https://maps.google.com/?q=alhomsi',
                      privacyPolicyText: 'سياسة الخصوصية',
                      onPrivacyPolicyTap: () {},
                      onSocialTap: (String url) {
                        context.read<UrlLauncherCubit>().launchUrl(url);
                      },
                    ),
                    const SizedBox(height: 5),
                    const Text("fhdsjgfusdgfysudfy", style: TextStyle(fontSize: 28)),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              const CustomHeader(),
              BlocBuilder<ScrollToTopCubit, bool>(
                builder: (context, showButton) {
                  if (!showButton) return const SizedBox.shrink();

                  double screenWidth = MediaQuery.of(context).size.width;
                  double leftPosition;

                  if (responsive.isDesktop || responsive.isTablet) {
                    leftPosition = (screenWidth - contentWidth) / 2 - 60;
                    if (leftPosition < 10) leftPosition = 10;
                  } else {
                    leftPosition = 10;
                  }

                  return Positioned(
                    bottom: 20,
                    left: leftPosition,
                    child: FloatingActionButton.small(
                      backgroundColor: AppColors.orange,
                      onPressed: () {
                        headerCubit.scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Icon(Icons.keyboard_arrow_up_outlined, color: AppColors.black1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}