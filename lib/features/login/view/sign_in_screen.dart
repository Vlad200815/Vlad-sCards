import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/consts.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/widgets/my_button.dart';
import '../widgets/widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final GlobalKey<FormState> signInKey = GlobalKey();

    return BlocListener<EmailAuthBloc, EmailAuthState>(
      listener: (context, state) {
        if (state is EmailSignInSuccessState) {
          Navigator.pushNamed(context, '/home');
          print("Light waight baby!!!");
        }
      },
      child: BlocListener<GoogleAuthBloc, GoogleAuthState>(
        listener: (context, state) {
          if (state is GoogleAuthSuccess) {
            Navigator.pushNamed(context, '/home');
          }
        },
        child: Scaffold(
          backgroundColor: theme.colorScheme.scrim,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SpetialButton(
                    onTap: () {
                      context.read<GoogleAuthBloc>().add(SignInWithGoogle());
                    },
                    text: "Login with Google",
                    widget: Image.asset("assets/google_logo.png"),
                  ),
                  SpetialButton(
                    onTap: () {},
                    text: "Login with Apple",
                    widget: Image.asset("assets/apple_logo.png"),
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
                          "or continue with email",
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.grey[800],
                          ),
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
                  Form(
                    key: signInKey,
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
                          keyboardType: TextInputType.number,
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/forgot_pswd'),
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.bodySmall!
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  MyBotton(
                    horizontal: MediaQuery.of(context).size.width / 3,
                    text: "Login",
                    onPressed: () {
                      print(emailTextEditingController.text);
                      print(passwordTextEditingController.text);
                      if (signInKey.currentState?.validate() ?? false) {
                        // Navigator.pushNamed(context, '/home');
                        context.read<EmailAuthBloc>().add(
                              SignInWithEmailEvent(
                                email: emailTextEditingController.text,
                                password: passwordTextEditingController.text,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "By siging in with an accout, you agree to Vlad'sCards'",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Terms of Service",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 1.9,
                            ),
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black,
                              decorationThickness: 1.9,
                            ),
                          ),
                        ],
                      ),
                    ),
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
