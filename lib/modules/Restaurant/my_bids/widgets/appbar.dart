import 'package:caterbid/core/widgets/base_appbar.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAppBar();
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

