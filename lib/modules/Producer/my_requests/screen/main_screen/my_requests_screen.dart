import 'package:caterbid/modules/Producer/my_requests/screen/widgets/appbar.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/widgets/request_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/modules/Producer/my_requests/bloc/requests_bloc.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/widgets/header_with_tabs.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class MyRequestsScreen extends StatefulWidget {
  static const String path = '/myrequests';
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  bool isActiveTab = true;

  @override
  void initState() {
    super.initState();
    context.read<RequestsBloc>().add(LoadRequests());
  }

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const ListAppbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSize(context, 16, 32, 60),
          ),
          child: Column(
            children: [
              SizedBox(height: h * 0.01),
              HeaderWithTabs(
                isActiveTab: isActiveTab,
                onActiveTap: () => setState(() => isActiveTab = true),
                onFulfilledTap: () => setState(() => isActiveTab = false),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<RequestsBloc, RequestsState>(
                  builder: (context, state) {
                    if (state is RequestsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RequestsLoaded) {
                      final requests = isActiveTab
                          ? state.activeRequests
                          : state.fulfilledRequests;

                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<RequestsBloc>().add(RefreshMyRequests());
                        },
                        child: RequestListView(requests: requests),
                      );
                    } else if (state is RequestsError) {
                      return Center(child: Text(state.message));
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
