import 'package:authentication_repository/authentication_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_app/ui/login/widgets/login_form.dart';
import 'cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (_) => LoginCubit(
            context.read<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
