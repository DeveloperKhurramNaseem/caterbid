import 'package:caterbid/modules/Restaurant/home/screen/widegts/sort_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/modules/Restaurant/home/bloc/get_requests_bloc.dart';

class RequestsSearchBar extends StatefulWidget {
  const RequestsSearchBar({super.key});

  @override
  State<RequestsSearchBar> createState() => _RequestsSearchBarState();
}

class _RequestsSearchBarState extends State<RequestsSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(); // Add FocusNode
  String? _currentSort;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _applySearch() {
    context.read<GetRequestsBloc>().add(
          SearchRequestsEvent(_searchController.text),
        );
  }

  void _applySort(String sortBy) {
    // UNfocus BEFORE state update
    _searchFocusNode.unfocus();

    setState(() => _currentSort = sortBy);
    context.read<GetRequestsBloc>().add(SortRequestsEvent(sortBy));
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);
    final height = Responsive.responsiveSize(context, 48, 54, 60);

    return Row(
      children: [
        // Search Field with FocusNode
        Expanded(
          child: SizedBox(
            height: height,
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode, // Attach
              onChanged: (_) => _applySearch(),
              decoration: InputDecoration(
                hintText: 'Search Requests',
                prefixIcon: Icon(
                  Icons.search,
                  size: Responsive.responsiveSize(context, 20, 22, 24),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: Responsive.responsiveSize(context, 12, 14, 16),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.25)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.35)),
                ),
              ),
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ),
        SizedBox(width: Responsive.responsiveSize(context, 8, 10, 12)),

        // Sort Button: Unfocus on tap + in onSelected
        GestureDetector(
          onTap: () {
            // Ensure no focus when opening
            _searchFocusNode.unfocus();
          },
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.responsiveSize(context, 10, 12, 14),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.25)),
            ),
            child: SortMenuButton(
              currentSort: _currentSort,
              onSelected: _applySort, // unfocus happens here
              fontSize: fontSize,
              iconSize: Responsive.responsiveSize(context, 20, 22, 24),
            ),
          ),
        ),
      ],
    );
  }
}