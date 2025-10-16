import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/modules/Producer/catering_request/bloc/cateringrequest_bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/repository/catering_repository.dart';
import 'package:caterbid/modules/Producer/home/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/repository/producer_repository.dart';
import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();

  // Added only for testing purpose
  if (!kReleaseMode) {
    await storage.deleteAll();
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
    );
  }
}
