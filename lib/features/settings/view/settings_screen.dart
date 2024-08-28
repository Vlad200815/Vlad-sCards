import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/features/settings/widgets/tile.dart';

import '../../login/blocs/email_auth_bloc/email_auth_bloc.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool themeSwitch = false;
  bool notificationsSwitch = true;
  bool analyticsSwitch = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            elevation: 3,
            backgroundColor: Colors.white,
            title: Text("Settings"),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
