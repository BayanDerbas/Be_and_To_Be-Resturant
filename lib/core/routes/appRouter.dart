import 'package:go_router/go_router.dart';
import 'package:web_app/features/order/presentation/pages/order.dart';
import '../../features/auth/presentation/pages/login&signup.dart';
import '../../features/branch/presentation/pages/branchSelection.dart';
import '../../features/cart/presentation/pages/cart.dart';
import '../../features/developers/presentation/developers.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../config/animations/loading.dart';
import '../../features/privacy/pages/privacy.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login_signup',
        builder: (context, state) => Login_SignupPage(),
      ),
      GoRoute(
        path: '/branch_selection',
        builder: (context, state) => const BranchSelectionPage(),
      ),
      GoRoute(
          path: '/home',
          builder: (context, state) => const Home()
      ),
      GoRoute(
        path: '/LoadinDount',
        builder: (context, state) => const LoadinDount(),
      ),
      GoRoute(
        path: '/Privacy',
        builder: (context,state) => const Privacy(),
      ),
      GoRoute(
        path: '/developers',
        builder: (context, state) => const Developers(),
      ),
      GoRoute(
        path: '/order',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return Order(
            name: args?['name'] ?? '',
            image: args?['image'] ?? '',
            price: args?['price'] ?? 0,
            types: args?['types'] ?? const [],
          );
        },
      ),
      GoRoute(
        path: '/card',
        builder: (context,state) => const Cart(),
      )
    ],
  );
}
