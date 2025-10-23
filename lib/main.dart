import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/modules/Producer/catering_request/bloc/cateringrequest_bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/repository/catering_repository.dart';
import 'package:caterbid/modules/Producer/home/active_request/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/bloc/bids_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/repository/producer_bid_repository.dart';
import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/bloc/business_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/repository/business_profile_repository.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/bloc/forget_password_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/repository/forget_password_repository.dart';
import 'package:caterbid/modules/auth/login/bloc/login_bloc.dart';
import 'package:caterbid/modules/auth/login/repository/login_repository.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_bloc.dart';
import 'package:caterbid/modules/auth/signup/repository/signup_repository.dart';
import 'package:caterbid/modules/auth/verify_email_screen/bloc/verify_otp_bloc.dart';
import 'package:caterbid/modules/auth/verify_email_screen/repository/verify_otp_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Added only for testing purpose
  if (!kReleaseMode) {
    await SecureStorage.clearToken();
    print('removed all secure storage data');
  }

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SignUpBloc(SignUpRepository())),
        BlocProvider(create: (_) => VerifyOtpBloc(VerifyOtpRepository())),
        BlocProvider(create: (_) => LoginBloc(LoginRepository())),
        BlocProvider(create: (_) => CateringrequestBloc(CateringRepository())),
        BlocProvider(create: (_) => ProducerHomeBloc(ProducerRepository())),
        BlocProvider(create: (_) => RequestsBloc(ProducerRepository())),
        BlocProvider(
          create: (_) => ForgetPasswordBloc(ForgetpasswordRepository()),
        ),
        BlocProvider(
          create: (_) => BusinessProfileBloc(BusinessProfileRepository()),
        ),
        // BlocProvider(create: (context) => BidsBloc(BidsRepository())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: AppFonts.nunito),

      routerConfig: appRouter,

      // <-- Global keyboard dismiss
      builder: (context, child) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          },
          child: child,
        );
      },
    );
  }
}
