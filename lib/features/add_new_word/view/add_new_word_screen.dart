import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../../../widgets/widgets.dart';
import '../widgets/widgets.dart';

class AddNewWordScreen extends StatefulWidget {
  const AddNewWordScreen({super.key});

  @override
  State<AddNewWordScreen> createState() => _AddNewWordScreenState();
}

class _AddNewWordScreenState extends State<AddNewWordScreen> {
  final TextEditingController englishEditingController =
      TextEditingController();
  final TextEditingController ukrainianEditingController =
      TextEditingController();
  final TextEditingController exampleEditingController =
      TextEditingController();

  final translator = GoogleTranslator();

  List<String> icons = [
    'airplane',
    'bag',
    'burger',
    'home',
    'pawprint',
    'ticket',
  ];

  String selectedIcon = '';

  @override
  void dispose() {
    englishEditingController.dispose();
    ukrainianEditingController.dispose();
    exampleEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.add_a_photo_outlined,
                  color: Colors.grey,
                  size: 80,
                ),
              ),
            ),
            WordInput(
              enabled: true,
              onEditingComplete: () async {
                try {
                  final translation = await translator.translate(
                    englishEditingController.text,
                    from: 'en',
                    to: "uk",
                  );

                  setState(() {
                    ukrainianEditingController.text = translation.text;
                  });
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              controller: englishEditingController,
              hintText: "english",
            ),
            WordInput(
              enabled: false,
              onEditingComplete: () async {},
              controller: ukrainianEditingController,
              hintText: "ukrainian",
            ),
            WordInput(
              enabled: true,
              onEditingComplete: () {},
              controller: exampleEditingController,
              hintText: "Example",
            ),
            const SizedBox(height: 20),
            MyButton(
              horizontal: 140,
              text: "Save",
              onPressed: () async {
                //saves data to database for the current user
              },
            ),
          ],
        ),
      ),
    );
  }
}
