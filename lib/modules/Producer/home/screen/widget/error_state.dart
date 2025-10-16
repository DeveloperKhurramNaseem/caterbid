import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorStateWidget<B extends BlocBase, E> extends StatelessWidget {
  final String message;
  final E retryEvent;

  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.retryEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '⚠️ $message',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.redAccent),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final bloc = context.read<B>();
                  (bloc as dynamic).add(retryEvent);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
