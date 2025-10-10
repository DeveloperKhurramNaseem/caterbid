import 'package:caterbid/modules/Producer/my_requests/screen/widgets/active_requests_tab.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/widgets/appbar.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/widgets/fulfilled_requests_tab.dart';
import 'package:caterbid/modules/Producer/my_requests/screen/widgets/header_with_tabs.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';


class MyRequestsScreen extends StatefulWidget {
  static const String path = '/myRequests';
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  bool isActiveTab = true;

//For API call and refresh the data
  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.responsiveSize(
      context,
      16,
      32,
      60,
    );

    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const Appbar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
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
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  color: AppColors.c500,
                  child: isActiveTab
                      ? const ActiveRequestsTab()
                      : const FulfilledRequestsTab(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
