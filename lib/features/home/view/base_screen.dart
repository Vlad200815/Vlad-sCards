import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlads_cards/general_blocs/save_words_bloc/save_words_bloc.dart';
import 'package:vlads_cards/widgets/widgets.dart';
import '../widgets/widgets.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  // static const MethodChannel channel = MethodChannel("my_channel");

  @override
  void initState() {
    // channel.setMethodCallHandler((MethodCall call) async {
    //   if (call.method == 'onGetLearnWords') {
    //     // Dispatch the event when the message is received
    //     context.read<SaveWordsBloc>().add(OnGetLearnWords());
    //   }
    // });
    context.read<SaveWordsBloc>().add(OnGetLearnWords());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: theme.colorScheme.onPrimary,
          floating: true,
          centerTitle: true,
          title: Text(
            "Vlad'sCards",
            style: theme.textTheme.titleLarge,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 15),
              BlocBuilder<SaveWordsBloc, SaveWordsState>(
                builder: (context, state) {
                  if (state is GetLearnWordsSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Box(
                            text: "${state.words.length}",
                            hint: "Learn",
                            textColor: Colors.blue,
                          ),
                          const Box(
                            //TODO: conect getMethod's logic to this text below!
                            text: "111",
                            hint: "Know",
                            textColor: Color.fromARGB(255, 46, 239, 52),
                          ),
                          const Box(
                            //TODO: conect getMethod's logic to this text below!
                            text: "237",
                            hint: "Learned",
                            textColor: Color.fromARGB(255, 255, 233, 34),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetLearnWordsProgress) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return const Center(child: Text("Something went wrong..."));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  height: 285,
                  child: Image.asset('assets/200.webp'),
                ),
              ),
              const SizedBox(height: 80),
              MyButton(
                horizontal: MediaQuery.of(context).size.width / 3,
                onPressed: () {
                  Navigator.pushNamed(context, '/training');
                },
                text: "Start",
              ),
              const SizedBox(height: 40),
              const CardsBox()
            ],
          ),
        ),
      ],
    );
  }
}
