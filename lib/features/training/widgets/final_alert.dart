import 'package:flutter/cupertino.dart';

class FinalAlert extends StatelessWidget {
  final String title;
  final Widget content;
  final String finalMessage;

  const FinalAlert({
    required this.title,
    required this.content,
    required this.finalMessage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: content,
      actions: [
        CupertinoDialogAction(
          child: CupertinoButton(
            child: Text(finalMessage),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/home',
              );
            },
          ),
        ),
      ],
    );
  }
}
