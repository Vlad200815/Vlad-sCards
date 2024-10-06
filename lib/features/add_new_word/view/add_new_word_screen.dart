import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:translator/translator.dart';
import 'package:vlads_cards/general_blocs/image_search_api/image_search_api_bloc.dart';
import 'package:vlads_cards/general_blocs/save_words_bloc/save_words_bloc.dart';
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
            const SizedBox(height: 30),
            Center(
              child: Text(
                "Add WORDS",
                style: theme.textTheme.bodyLarge!.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            BlocBuilder<ImageSearchApiBloc, ImageSearchApiState>(
              builder: (context, state) {
                if (state is ImageSearchApiSuccess) {
                  return SizedBox(
                    height: 200,
                    width: 300,
                    child: Image.network(state.url),
                  );
                } else if (state is ImageSearchApiProgress) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return SizedBox(
                    height: 200,
                    width: 300,
                    child: Image.asset("assets/flash-card.png"),
                  );
                }
              },
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
                  context.read<ImageSearchApiBloc>().add(
                      OnSearchImageEvent(query: englishEditingController.text));
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
                //saves data to preferences for the current added word
                context.read<SaveWordsBloc>().add(
                      OnSaveLearnWords(
                        listMap: {
                          "english": englishEditingController.text,
                          "ukrainian": ukrainianEditingController.text,
                          "example": exampleEditingController.text,
                          "repetition": 0
                        },
                      ),
                    );
                GetIt.I<Talker>().debug(
                    "english: ${englishEditingController.text}, ukrainian: ${ukrainianEditingController.text}, example: ${exampleEditingController.text}");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
