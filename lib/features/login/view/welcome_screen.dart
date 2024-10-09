import 'package:flutter/material.dart';
import 'view.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimaryFixed,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 50),
          Text("Welcome to Vlad'sCards", style: theme.textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            "Login or Sign up to access your",
            style: theme.textTheme.bodyMedium!.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 1),
          Text("account", style: theme.textTheme.bodyMedium),
          const SizedBox(height: 10),
          TabBar(
            indicatorColor: theme.colorScheme.onPrimary,
            dividerHeight: 0,
            enableFeedback: true,
            indicator: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.onPrimary,
              ),
              color: theme.colorScheme.onPrimary,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            controller: tabController,
            unselectedLabelColor: const Color.fromRGBO(255, 255, 255, 1),
            labelColor: Colors.black,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text("Login", style: theme.textTheme.bodyLarge),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text("Sign Up", style: theme.textTheme.bodyLarge),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                SignInScreen(),
                SignUpScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
