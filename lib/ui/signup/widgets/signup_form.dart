import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:podcast_app/ui/signup/cubit/signup_cubit.dart';
import 'package:podcast_app/ui/signup/cubit/signup_state.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          print("terjadi kesalahan");
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(),
              SizedBox(height: 40),
              _EmaiInput(),
              SizedBox(height: 40),
              _PasswordInput(),
              SizedBox(height: 40),
              _ConfrimPasswordInput(),
              SizedBox(height: 40),
              _SignUpButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _EmaiInput extends StatelessWidget {
  const _EmaiInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (passsword) =>
              context.read<SignUpCubit>().passwordChanged(passsword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _ConfrimPasswordInput extends StatelessWidget {
  const _ConfrimPasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmedPassword) => context
              .read<SignUpCubit>()
              .confirmPasswordChanged(confirmedPassword),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirmed Password',
            helperText: '',
            errorText:
                state.confirmedPassword.invalid ? 'password not match' : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
                child: Text('Signup'),
              );
      },
    );
  }
}
