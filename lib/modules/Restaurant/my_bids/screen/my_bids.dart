import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/screen/widegts/bids_header.dart';
import 'package:caterbid/modules/Restaurant/my_bids/widgets/active_bids_tab.dart';
import 'package:caterbid/modules/Restaurant/my_bids/widgets/fulfilled_bids_tab.dart' show FulfilledRequestsTab;
import 'package:caterbid/modules/Restaurant/my_bids/widgets/header_with_tabs.dart';
import 'package:flutter/material.dart';


class MyBids extends StatefulWidget {
  static const String path = '/mybids';
  const MyBids({super.key});

  @override
  State<MyBids> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyBids> {
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
