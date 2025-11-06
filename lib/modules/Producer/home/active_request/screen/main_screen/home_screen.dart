import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request/bloc/producer_home_bloc.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/error_state.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/home_appbar.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/home_empty_state.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/home_loaded_section.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/home_loading_section.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/home_refresh_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProducerHomeScreen extends StatefulWidget {
  static const path = '/producer_home';
  final bool? extra;

  const ProducerHomeScreen({super.key, this.extra});

  @override
  State<ProducerHomeScreen> createState() => _ProducerHomeScreenState();
}

class _ProducerHomeScreenState extends State<ProducerHomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<ProducerHomeBloc>().add(FetchProducerRequests());

    // Fetch latest profile from API
    context.read<RequesteeProfileBloc>().add(
      LoadRequesteeProfileEvent(),
      
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Re-fetch when app comes to foreground
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<ProducerHomeBloc>().add(RefreshProducerRequests());
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const ProducerAppBar(),
      body: SafeArea(
        child: HomeRefreshWrapper(
          onRefresh: () async {
            context.read<ProducerHomeBloc>().add(RefreshProducerRequests());
            await Future.delayed(const Duration(seconds: 2));
          },
          child: BlocBuilder<ProducerHomeBloc, ProducerHomeState>(
            builder: (context, state) {
              if (state is ProducerHomeLoading) {
                return HomeLoadingSection(w: w, h: h);
              } else if (state is ProducerHomeError) {
                return ErrorStateWidget<ProducerHomeBloc, ProducerHomeEvent>(
                  message: state.message,
                  retryEvent: FetchProducerRequests(),
                );
              } else if (state is ProducerHomeEmpty) {
                return const ProducerEmptyState();
              } else if (state is ProducerHomeLoaded) {
                if (state.requests.isEmpty) {
                  return const ProducerEmptyState();
                }
                return HomeLoadedSection(requests: state.requests, w: w, h: h);
              }
              return HomeLoadingSection(w: w, h: h);
            },
          ),
        ),
      ),
    );
  }
}
