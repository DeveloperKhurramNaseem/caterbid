import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/utils/helpers/storage/prefs/secure_storage.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/repository/requestee_profile_repository.dart';
import 'package:caterbid/modules/Producer/catering_request/bloc/cateringrequest_bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/repository/catering_repository.dart';
import 'package:caterbid/modules/Producer/home/active_request/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/repository/provider_profile_repository.dart';
import 'package:caterbid/modules/Restaurant/business_profile/bloc/business_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/repository/business_profile_repository.dart';
import 'package:caterbid/modules/Restaurant/my_bids/bloc/get_my_bids_bloc.dart';
import 'package:caterbid/modules/Restaurant/my_bids/repository/get_my_bids_repository.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/bloc/forget_password_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/repository/forget_password_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/routes/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugPrintRebuildDirtyWidgets = true; 

  final apiService = ApiService();

  // // Added only for testing purpose
  // if (!kReleaseMode) {
  //   await SecureStorage.clearToken();
  //   print('removed all secure storage data');
    
    
  // }

  runApp(
    MultiBlocProvider(
      providers: [
        // BlocProvider(create: (_) => SignUpBloc(SignUpRepository())),
        // BlocProvider(create: (_) => LoginBloc(LoginRepository())),
        BlocProvider(create: (_) => CateringrequestBloc(CateringRepository())),
        BlocProvider(create: (_) => ProducerHomeBloc(ProducerRepository())),
        BlocProvider(create: (_) => RequestsBloc(ProducerRepository())),
        BlocProvider(
          create: (_) => ForgetPasswordBloc(ForgetpasswordRepository()),
        ),
        BlocProvider(create: (_) => ProviderProfileBloc(ProviderRepository())),

        BlocProvider(
          create: (_) => RequesteeProfileBloc(RequesteeRepository()),
        ),
        BlocProvider(
          create: (_) => BusinessProfileBloc(BusinessProfileRepository()),
        ),
            BlocProvider(create: (_) => GetMyBidsBloc(GetMyBidsProducerRepository(apiService: apiService))),

        
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
