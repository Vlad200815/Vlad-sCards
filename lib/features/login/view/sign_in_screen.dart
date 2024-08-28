import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/consts.dart';
import 'package:vlads_cards/features/login/blocs/email_auth_bloc/email_auth_bloc.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/widgets/my_button.dart';
import '../../../widgets/widgets.dart';
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

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              BlocBuilder<GoogleAuthBloc, GoogleAuthState>(
                builder: (context, state) {
                  if (state is GoogleAuthProgress) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return BlocListener<GoogleAuthBloc, GoogleAuthState>(
                    listener: (context, state) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/home",
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: SpetialButton(
                      onTap: () {
                        context.read<GoogleAuthBloc>().add(SignInWithGoogle());
                      },
                      text: "Login with Google",
                      widget: Image.asset("assets/google_logo.png"),
                    ),
                  );
                },
              ),

              // BlocBuilder<FacebookAuthBloc, FacebookAuthState>(
              //   builder: (context, state) {
              //     if (state is FacebookAuthSeccuss) {
              //       Navigator.pushNamed(context, '/home');
              //     } else if (state is FacebookAuthProgress) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else {
              //       const Center(child: Text("Something went wrong..."));
              //     }
              //     return SpetialButton(
              //       onTap: () {
              //         context
              //             .read<FacebookAuthBloc>()
              //             .add(FacebookSignInEvent());
              //       },
              //       text: "Login with Facebook",
              //       widget: Image.asset("assets/facebook_logo.png"),
              //     );
              //   },
              // ),

              SpetialButton(
                onTap: () async {
                  // final LoginResult loginResult =
                  //     await FacebookAuth.instance.login();
                  // final OAuthCredential facebookAuthCredential =
                  //     FacebookAuthProvider.credential(
                  //         loginResult.accessToken!.tokenString);
                  // UserCredential userCredential = await FirebaseAuth
                  //     .instance
                  //     .signInWithCredential(facebookAuthCredential);
                  // print(userCredential.user);
                },
                text: "Login with Facebook",
                widget: Image.asset("assets/facebook_logo.png"),
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
              const SizedBox(height: 45),

              MyButton(
                horizontal: MediaQuery.of(context).size.width / 3,
                text: "Login",
                onPressed: () {
                  debugPrint(emailTextEditingController.text);
                  debugPrint(passwordTextEditingController.text);
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

              const SizedBox(height: 45),
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
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: TextStyle(
                          color: theme.colorScheme.inversePrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              theme.colorScheme.inversePrimary.withOpacity(0.8),
                          decorationThickness: 1,
                        ),
                      ),
                      const TextSpan(
                        text: " and ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Privacy Policy.",
                        style: TextStyle(
                          color: theme.colorScheme.inversePrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          decorationColor:
                              theme.colorScheme.inversePrimary.withOpacity(0.8),
                          decorationThickness: 1,
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
    );
  }
}
