import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorouter_auth/app/routes/app_router.dart';
import '../../../../app/routes/route_utils.dart';
import '../controller/auth_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            failed: () => AppRouter.router.go(PAGES.login.screenPath),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.when(
              initial: () => const SizedBox(),
              success: (r) => Center(
                child: TextButton(
                  child: const Text(
                    'Logout',
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthEvent.logout());
                    AppRouter.router.go(PAGES.login.screenPath);
                  },
                ),
              ),
              failed: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
