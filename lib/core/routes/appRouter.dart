import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login&signup.dart';
import '../../features/branch/presentation/pages/branchSelection.dart';
import '../../features/home/presentation/pages/home.dart';
import '../../config/animations/loading.dart';

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
    ],
  );
}
