import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlads_cards/features/login/blocs/google_auth_bloc/google_auth_bloc.dart';
import 'package:vlads_cards/features/settings/widgets/flame.dart';
import 'package:vlads_cards/features/settings/widgets/tile.dart';
import 'package:vlads_cards/general_blocs/what_login_cubit/what_login_cubit.dart';
import '../../../general_blocs/theme_change_cubit/theme_change_cubit.dart';
import '../../login/blocs/email_auth_bloc/email_auth_bloc.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsSwitch = true;
  bool analyticsSwitch = true;

  final Uri url = Uri.parse("https://web.telegram.org/a/#-1002212606784_1");

  Future<void> launchTelegramUrl() async {
    if (!await launchUrl(url)) {
      throw Exception("Could not launch $url");
    }
  }

  String createNameFromEmail(String email) {
    List<String> emailList = email.split('');
    List<String> nameLetters = [];

    for (var letter in emailList) {
      if (letter.contains(RegExp(r'[a-z]'))) {
        nameLetters.add(letter);
      } else {
        break;
      }
    }
    String result = nameLetters.join('').toUpperCase();
    return result.isNotEmpty ? result : "ANONIMUSE";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool themeSwitch = context.read<ThemeChangeCubit>().isDark();
    return Scaffold(
      body: BlocListener<EmailAuthBloc, EmailAuthState>(
        listener: (context, state) {
          if (state is EmailSignOutSuccessState) {
            Navigator.pushNamed(context, '/');
          }
        },
        child: BlocListener<GoogleAuthBloc, GoogleAuthState>(
          listener: (context, state) {
            if (state is GoogleAutSignOuthSuccess) {
              Navigator.pushNamed(context, '/');
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 3,
                backgroundColor: theme.colorScheme.onPrimary,
                title: const Text("Settings"),
                automaticallyImplyLeading: false,
                centerTitle: true,
                expandedHeight: 70,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.06,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onTertiary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 6),
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: const CircleAvatar(
                                  radius: 60,
                                  backgroundImage: AssetImage(
                                    "assets/user.png",
                                  ),
                                ),
                              ),
                              const Flame()
                            ],
                          ),
                          BlocBuilder<WhatLoginCubit, WhatLoginState>(
                            builder: (context, state) {
                              GetIt.I<Talker>()
                                  .warning("whatLogin: ${state.whatLogin}");
                              if (state.whatLogin == 'google') {
                                return BlocBuilder<GoogleAuthBloc,
                                    GoogleAuthState>(
                                  builder: (context, state) {
                                    if (state is GoogleAuthSuccess) {
                                      return Column(
                                        children: [
                                          Text(
                                            createNameFromEmail(
                                                state.myUser.email),
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                          Text(
                                            state.myUser.email,
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          "UNDERFIND",
                                          style: TextStyle(
                                            color: theme
                                                .colorScheme.inversePrimary,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              } else if (state.whatLogin == 'email' &&
                                  state.inOrUp == 'in') {
                                return BlocBuilder<EmailAuthBloc,
                                    EmailAuthState>(
                                  builder: (context, state) {
                                    if (state is EmailSignInSuccessState) {
                                      return Column(
                                        children: [
                                          Text(
                                            createNameFromEmail(
                                                state.myEmailUser.email),
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                          Text(
                                            state.myEmailUser.email,
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          "UNDERFIND",
                                          style: TextStyle(
                                            color: theme
                                                .colorScheme.inversePrimary,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              } else if (state.whatLogin == 'email' &&
                                  state.inOrUp == 'up') {
                                return BlocBuilder<EmailAuthBloc,
                                    EmailAuthState>(
                                  builder: (context, state) {
                                    if (state is EmailSignUpSuccessState) {
                                      return Column(
                                        children: [
                                          Text(
                                            createNameFromEmail(
                                                state.myUser.email),
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                          Text(
                                            state.myUser.email,
                                            style: TextStyle(
                                              color: theme
                                                  .colorScheme.inversePrimary,
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          "UNDERFIND",
                                          style: TextStyle(
                                            color: theme
                                                .colorScheme.inversePrimary,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "UNDERFIND",
                                    style: TextStyle(
                                      color: theme.colorScheme.inversePrimary,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    MySwitch(
                      text: "Dark Theme",
                      value: themeSwitch,
                      onChanged: (value) {
                        context.read<ThemeChangeCubit>().setThemeBrightness(
                              value ? Brightness.dark : Brightness.light,
                            );
                        setState(() {
                          themeSwitch = value;
                        });
                      },
                    ),
                    MySwitch(
                      text: "Notifications",
                      value: notificationsSwitch,
                      onChanged: (value) {
                        setState(() {
                          notificationsSwitch = value;
                        });
                      },
                    ),
                    MySwitch(
                      text: "Allow Analitics",
                      value: analyticsSwitch,
                      onChanged: (value) {
                        setState(() {
                          analyticsSwitch = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    MyTile(
                      icon: const Icon(
                        Icons.door_back_door,
                        color: Colors.red,
                        size: 30,
                      ),
                      text: "Sign Out",
                      onPressed: () {
                        // context.read<EmailAuthBloc>().add(SignOut());
                        context.read<GoogleAuthBloc>().add(SignOutWithGoogle());
                      },
                    ),
                    MyTile(
                      icon: const Icon(
                        Icons.telegram,
                        color: Colors.blue,
                        size: 30,
                      ),
                      text: "Report a Bug",
                      onPressed: () async {
                        await launchTelegramUrl();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
