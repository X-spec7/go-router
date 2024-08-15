import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gorouter_auth/app/routes/app_router.dart';
import 'package:gorouter_auth/app/routes/route_utils.dart';
import 'package:gorouter_auth/features/auth/presentation/controller/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: const Text(
            'Login',
          ),
          onPressed: (){
            context.read<AuthBloc>().add(const AuthEvent.login());
            AppRouter.router.go(PAGES.home.screenPath);
          },
        ),
      ),
    );
  }
}
