import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:vlads_cards/consts.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/features/login/widgets/widgets.dart';
import 'package:vlads_cards/general_blocs/what_login_cubit/what_login_cubit.dart';
import 'package:vlads_cards/widgets/widgets.dart';

import '../../../repositories/login/models/models.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isHidden = false;

  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController repeatPasswordTextEditingController =
      TextEditingController();

  bool isEquil = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<FormState> signUpKey = GlobalKey();

    return BlocListener<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          context.read<WhatLoginCubit>().whatLogin("google", 'in');
          GetIt.I<Talker>().warning('goole');
          Navigator.pushNamed(context, '/home');
        }
      },
      child: BlocListener<EmailAuthBloc, EmailAuthState>(
        listener: (context, state) {
          if (state is EmailSignUpSuccessState) {
            context.read<WhatLoginCubit>().whatLogin("email", "up");
            GetIt.I<Talker>().warning('email');
            Navigator.pushNamed(context, '/home');
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.onPrimary,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Register a new account with Email",
                      style: TextStyle(
                        color: theme.colorScheme.inversePrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: signUpKey,
                    child: Column(
                      children: [
                        LoginInput(
                          controller: emailTextEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validationRegExp: EMAIL_VALIDATION_REGEX,
                          hintText: "Email Address",
                          obscureText: false,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        const SizedBox(height: 15),
                        LoginInput(
                          controller: passwordTextEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          validationRegExp: PASSWORD_VALIDATION_REGEX,
                          hintText: "Password",
                          obscureText: isHidden,
                          prefixIcon: const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden == false
                                  ? Icons.remove_red_eye_rounded
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        LoginInput(
                          controller: repeatPasswordTextEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          validationRegExp: PASSWORD_VALIDATION_REGEX,
                          hintText: "Conform password",
                          obscureText: isHidden,
                          prefixIcon: const Icon(Icons.lock_open),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHidden == false
                                  ? Icons.remove_red_eye_rounded
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1.3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          "or continue with google",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SpetialButton(
                    onTap: () {
                      context.read<GoogleAuthBloc>().add(SignInWithGoogle());
                    },
                    text: "Sign Up with Google",
                    widget: Image.asset("assets/google_logo.png"),
                  ),
                  const SizedBox(height: 50),
                  MyButton(
                    horizontal: MediaQuery.of(context).size.width / 3,
                    text: "Sign Up",
                    onPressed: () {
                      if (signUpKey.currentState?.validate() ?? false) {
                        if (passwordTextEditingController.text ==
                            repeatPasswordTextEditingController.text) {
                          setState(() {
                            isEquil = true;
                          });
                          MyUser myEmailUser = MyUser(
                            id: const Uuid().v1(),
                            email: emailTextEditingController.text,
                            password: passwordTextEditingController.text,
                          );

                          context
                              .read<EmailAuthBloc>()
                              .add(SignUpWithEmailEvent(myUser: myEmailUser));

                          debugPrint(emailTextEditingController.text);
                          debugPrint(passwordTextEditingController.text);
                          debugPrint(repeatPasswordTextEditingController.text);
                          debugPrint(isEquil.toString());
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
