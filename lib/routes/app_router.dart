import 'package:caterbid/core/widgets/bottomtabbar.dart';
import 'package:caterbid/modules/Producer/accept_bid/screen/main_screen/payment_screen.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/change_password.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/screen/delete_account_screen.dart.dart';
import 'package:caterbid/modules/Producer/account_settings/edit_profile/main_screen/edit_profile_screen.dart';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Producer/catering_request/screen/main_screen/request_screen.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/main_screen/my_requests_screen.dart';
import 'package:caterbid/modules/Producer/payment/screen/main_screen/payment_success_screen.dart';
import 'package:caterbid/modules/Producer/account_settings/main_settings/main_screen/setting_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/Restaurant/home/main_screen/bids_home.dart';
import 'package:caterbid/modules/Restaurant/my_bids/screen/my_bids.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/forgetpassword_screen/main_screen/forgetpassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:caterbid/modules/auth/signup/screen/main_screen/signup_screen.dart';
import 'package:caterbid/modules/auth/verify_email_screen/main_screen/verify_email_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    // ---------- AUTH ROUTES ----------
    GoRoute(
      path: SignUpScreen.path,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: VerifyEmailScreen.path,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        assert(extra != null, 'You must pass data using "extra" when navigating to VerifyEmailScreen');

        final email = extra?['email'] ?? '';
        final role = extra?['role'] ?? '';
        return VerifyEmailScreen(email: email, role: role);
      },
    ),

    GoRoute(
      path: ForgetPasswordScreen.path,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),

    // ---------- App Settings ROUTES ----------
    GoRoute(
      path: SettingsScreen.path,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: EditProfileScreen.path,
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: ChangePasswordScreen.path,
      builder: (context, state) => const ChangePasswordScreen(),
    ),
    GoRoute(
      path: DeleteAccountScreen.path,
      builder: (context, state) => const DeleteAccountScreen(),
    ),

    // ---------- PRODUCER APP ROUTES ----------
    GoRoute(
      path: NewCateringRequestScreen.path,
      builder: (context, state) => const NewCateringRequestScreen(),
    ),
    GoRoute(
      path: PaymentScreen.path,
      builder: (context, state) => const PaymentScreen(),
    ),
    GoRoute(
      path: PaymentSuccessScreen.path,
      builder: (context, state) => const PaymentSuccessScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) => BottomNavBar(
        navigationShell: navShell,
        items: [
          NavItem(
            label: 'Home',
            icon: Icons.home,
            route: ProducerHomeScreen.path,
          ),
          NavItem(label: 'My Bids', icon: Icons.checklist, route: MyBids.path),
        ],
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProducerHomeScreen.path,
              builder: (context, state) => const ProducerHomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MyRequestsScreen.path,
              builder: (context, state) => const MyRequestsScreen(),
            ),
          ],
        ),
      ],
    ),

    // ---------- Restaurant APP ROUTES ----------
    GoRoute(
      path: SetBusinessProfileScreen.path,
      builder: (context, state) => const SetBusinessProfileScreen(),
    ),
    GoRoute(
      path: PlaceBidScreen.path,
      builder: (context, state) => const PlaceBidScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) => BottomNavBar(
        navigationShell: navShell,
        items: [
          NavItem(label: 'Home', icon: Icons.home, route: MyBidsScreen.path),
          NavItem(
            label: 'My Bids',
            icon: Icons.checklist,
            route: MyRequestsScreen.path,
          ),
        ],
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MyBidsScreen.path,
              builder: (context, state) => const MyBidsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MyBids.path,
              builder: (context, state) => const MyBids(),
            ),
          ],
        ),
      ],
    ),
  ],
);
