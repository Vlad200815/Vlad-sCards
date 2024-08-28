import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool themeSwitch = false;
  bool notificationsSwitch = false;
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
