import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vlads_cards/features/settings/widgets/tile.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool themeSwitch = context.read<ThemeChangeCubit>().isDark();
    return Scaffold(
      body: CustomScrollView(
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
                const SizedBox(height: 12),
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
                    context.read<EmailAuthBloc>().add(SignOut());
                    Navigator.pushNamed(context, '/');
                  },
                ),
                MyTile(
                  icon:
                      const Icon(Icons.telegram, color: Colors.blue, size: 30),
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
    );
  }
}
