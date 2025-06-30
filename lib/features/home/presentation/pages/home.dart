import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:web_app/core/constants/app_images.dart';
import 'package:web_app/features/developers/presentation/developers.dart';
import '../../../../config/ResponsiveUI/responsiveConfig.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../config/animations/customLottieButton.dart';
import '../../../order/presentation/pages/order.dart';
import '../../../privacy/pages/privacy.dart';
import '../cubit/header/header_cubit.dart';
import '../cubit/products/products_cubit.dart';
import '../cubit/scrollToTop/scroll_to_top_cubit.dart';
import '../cubit/typesProduct/types_product_cubit.dart';
import '../cubit/urlLauncher/url_launcher_cubit.dart';
import '../widgets/CustomBanner.dart';
import '../widgets/CustomDrawer.dart';
import '../widgets/CustomFooter.dart';
import '../widgets/CustomHeader.dart';
import '../widgets/CustomListTypesProduct.dart';
import '../widgets/CustomMenu.dart';
import '../widgets/CustomMenuTitle.dart';
import '../widgets/CustomProductCarousel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey _aboutSectionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final headerCubit = context.read<HeaderCubit>();
    final productsCubit = context.read<ProductsCubit>();
    final productTypesCubit = context.read<ProductTypesCubit>();
    final responsive = ResponsiveConfig.of(context);

    double contentWidth =
    (responsive.isDesktop || responsive.isTablet)
        ? 800
        : MediaQuery.of(context).size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productsState = productsCubit.state;
      if (productsState is ProductsLoaded) {
        final productName =
        productsState.products[productsState.selectedIndex]['name']!;
        productTypesCubit.loadTypesForProduct(productName);
      }
    });

    return BlocProvider(
      create: (_) => ScrollToTopCubit(headerCubit.scrollController),
      child: Scaffold(
        backgroundColor: AppColors.smooky,
        endDrawer: CustomDrawer(
          isLoggedIn: true,
          onLogout: () {
            context.go('/login_signup');
          },
        ),
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
                                  final productName =
                                  state.products[state.selectedIndex]['name']!;
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
                          return CustomListTypesProductList(
                            types: state.types,
                            contentWidth: contentWidth,
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    const SizedBox(height: 45),
                    CustomFooter(
                      phoneNumbers: [
                        '05050530004',
                        '05322277790',
                        '05333388830',
                      ],
                      logoAsset: AppImages.logo_header,
                      facebookUrl: 'https://facebook.com/alhomsi',
                      instagramUrl: 'https://instagram.com/alhomsi',
                      mapsUrl: 'https://maps.google.com/?q=alhomsi',
                      privacyPolicyText: 'سياسة الخصوصية',
                      onPrivacyPolicyTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.transparent,
                            child: const Privacy(),
                          ),
                        );
                      },
                      onSocialTap: (String url) {
                        context.read<UrlLauncherCubit>().launchUrl(url);
                      },
                    ),
                    const SizedBox(height: 5),
                    Container(
                      key: _aboutSectionKey,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          const Text(
                            "القائمة من إعداد أميرة ريا وبيان درباس للتواصل يرجى النقر على",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 12),
                          CustomLottieButton(
                            assetPath: "animations/Animation.json",
                            width: 50,
                            height: 50,
                            onTap: () {
                              showBarModalBottomSheet(
                                context: context,
                                builder: (context) => const Developers(),
                                expand: false,
                                backgroundColor: Colors.transparent,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) => CustomHeader(
                  onAboutTap: () {
                    Scrollable.ensureVisible(
                      _aboutSectionKey.currentContext!,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ),
              BlocBuilder<ScrollToTopCubit, bool>(
                builder: (context, showButton) {
                  if (!showButton) return const SizedBox.shrink();

                  double screenWidth = MediaQuery.of(context).size.width;
                  double leftPosition =
                  (responsive.isDesktop || responsive.isTablet)
                      ? (screenWidth - contentWidth) / 2 - 60
                      : 10;

                  return Positioned(
                    bottom: 20,
                    left: leftPosition < 10 ? 10 : leftPosition,
                    child: FloatingActionButton.small(
                      backgroundColor: AppColors.orange,
                      onPressed: () {
                        headerCubit.scrollController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.black1,
                      ),
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
