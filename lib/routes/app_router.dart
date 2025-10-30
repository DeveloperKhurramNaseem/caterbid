import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/widgets/bottomtabbar.dart';
import 'package:caterbid/modules/Producer/accept_bid/screen/main_screen/payment_screen.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/main_screen/change_password.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/screen/delete_account_screen.dart.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/main_screen/edit_profile_screen.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Producer/catering_request/screen/main_screen/request_screen.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/main_screen/my_requests_screen.dart';
import 'package:caterbid/modules/Producer/payment/screen/main_screen/payment_success_screen.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/main_screen/requestee_setting_screen.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/change_password/screen/main_screen/change_password.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/screen/delete_account_screen.dart.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/main_screen/provider_edit_profile_screen.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/screen/provider_settings_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/Restaurant/home/bloc/get_requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/home/model/formatted_request_model.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:caterbid/modules/Restaurant/home/screen/main_screen/bids_home.dart';
import 'package:caterbid/modules/Restaurant/my_bids/bloc/get_my_bids_bloc.dart';
import 'package:caterbid/modules/Restaurant/my_bids/repository/get_my_bids_repository.dart';
import 'package:caterbid/modules/Restaurant/my_bids/screen/my_bids.dart';
import 'package:caterbid/modules/Restaurant/place_bid/bloc/place_bid_bloc.dart';
import 'package:caterbid/modules/Restaurant/place_bid/repository/place_bid_repository.dart';
import 'package:caterbid/modules/Restaurant/place_bid/screen/place_bid_screen.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/bloc/change_password_request_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/repository/change_password_request_repository.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/mainscreen/ChangePasswordScreen.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/bloc/verify_reset_otp_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/main_screen/OTPScreen.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/screen/main_screen/forgetpassword_screen.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/repository/verify_otp_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:caterbid/modules/auth/signup/screen/main_screen/signup_screen.dart';
import 'package:caterbid/modules/auth/verify_email_screen/screen/main_screen/verify_email_screen.dart';

final GoRouter appRouter = GoRouter(
  restorationScopeId: null,

  initialLocation: LoginScreen.path,
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
        // assert(
        //   extra != null,
        //   'You must pass data using "extra" when navigating to VerifyEmailScreen',
        // );

        final email = extra?['email'] ?? '';
        final role = extra?['role'] ?? '';
        // final companyName = extra?['companyName'] ?? '';
        final phoneNumber = extra?['phoneNumber'] ?? '';

        return VerifyEmailScreen(
          email: email,
          role: role,
          // companyName: companyName,
          phoneNumber: phoneNumber,
        );
      },
    ),

    // ---------- ForgetPassword ROUTES ----------
    GoRoute(
      path: ForgetPasswordScreen.path,
      builder: (context, state) => const ForgetPasswordScreen(),
    ),
    GoRoute(
      path: OTPScreen.path,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final email = extra?['email'] ?? '';

        return BlocProvider(
          create: (_) => VerifyResetOtpBloc(VerifyOtpRepository()),
          child: OTPScreen(email: email),
        );
      },
    ),
    GoRoute(
      path: ChangePasswordScreen.path,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        //For Testing
        // assert(extra != null && extra['email'] != null, 'Email required');

        final email = extra!['email'] as String;

        return BlocProvider(
          create: (_) => ChangePasswordRequestBloc(ChangePasswordRepository()),
          child: ChangePasswordScreen(email: email),
        );
      },
    ),

    // ---------- Requestee App Settings ROUTES ----------
    GoRoute(
      path: RequesteeEditProfileScreen.path,
      builder: (context, state) => const RequesteeEditProfileScreen(),
    ),
    GoRoute(
      path: RequesteeSettingsScreen.path,
      builder: (context, state) => const RequesteeSettingsScreen(),
    ),
    GoRoute(
      path: RequesteeSettingsChangePassword.path,
      builder: (context, state) => const RequesteeSettingsChangePassword(),
    ),
    GoRoute(
      path: RequesteeDeleteAccountScreen.path,
      builder: (context, state) => const RequesteeDeleteAccountScreen(),
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
          NavItem(
            label: 'My Requests',
            icon: Icons.checklist,
            route: MyBids.path,
          ),
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

    // ---------- Provider APP ROUTES ----------
    GoRoute(
      path: SetBusinessProfileScreen.path,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;

        final phoneNumber = extra?['phoneNumber'] ?? '';

        return SetBusinessProfileScreen(phoneNumber: phoneNumber);
      },
    ),
    GoRoute(
      path: PlaceBidScreen.path,
      builder: (context, state) {
        final request = state.extra as FormattedProviderRequest;

        return BlocProvider(
          create: (_) => PlaceBidBloc(PlaceBidRepository()),
          child: PlaceBidScreen(request: request),
        );
      },
    ),

    // ---------- Provider App Settings ROUTES ----------
    GoRoute(
      path: ProviderEditProfileScreen.path,
      builder: (context, state) => const ProviderEditProfileScreen(),
    ),
    GoRoute(
      path: ProviderSettingsScreen.path,
      builder: (context, state) => const ProviderSettingsScreen(),
    ),
    GoRoute(
      path: ProviderChangePasswordScreen.path,
      builder: (context, state) => const ProviderChangePasswordScreen(),
    ),
    GoRoute(
      path: ProviderDeleteAccountScreen.path,
      builder: (context, state) => const ProviderDeleteAccountScreen(),
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
              builder: (context, state) {
                return BlocProvider(
                  create: (context) =>
                      GetRequestsBloc(ProviderRequestsRepository())
                        ..add(StartListeningRequests()),
                  child: const MyBidsScreen(),
                );
              },
            ),
          ],
        ),

        StatefulShellBranch(
          routes: [
            GoRoute(
              path: MyBids.path,
              builder: (context, state) {
                return BlocProvider(
                  create: (context) => GetMyBidsBloc(
                    GetMyBidsProducerRepository(apiService: ApiService()),
                  ),
                  child: const MyBids(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
