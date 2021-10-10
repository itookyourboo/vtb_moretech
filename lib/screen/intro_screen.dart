import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moretech_vtb/assets/vtb_ui_typography.dart' as VtbTypography;

class IntroScreen extends StatefulWidget {
  final Function(String name, int age) passed;

  const IntroScreen(this.passed, {Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<List<String>> texts = [
    [
      'Привет!',
      'Меня зовут Вика!\nЯ буду твоим финансовым наставником!',
      'Никаких скучных тестов и кучи теории.',
      'Изучай финансовую грамотность\nиграючи!',
      'Для начала ответь на\nнесколько простых вопросов.',
      'Как тебя зовут?'
    ],
    [
      'Приятно познакомиться, ',
      'Укажи свой возраст,\nчтобы я подобрала подходящую программу.'
    ],
    ['Да это же самые лучшие годы!', 'Ну что, начнем!']
  ];
  int _stage = 0;
  late String _name;
  late int _age;
  late List<Widget> children;

  @override
  void initState() {
    super.initState();
    children = [getAnimatedTextKitByStage(0)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children)));
  }

  AnimatedTextKit getAnimatedTextKitByStage(int stage) {
    return AnimatedTextKit(
      key: ValueKey<int>(stage),
      isRepeatingAnimation: false,
      displayFullTextOnTap: true,
      animatedTexts: List.of(texts[stage].map((text) => TyperAnimatedText(text,
          speed: Duration(milliseconds: 50),
          textAlign: TextAlign.center,
          textStyle: VtbTypography.body1))),
      onFinished: () {
        setState(() {
          print('added form ' + stage.toString());
          children.add(getFormByStage(stage));
        });
      },
    );
  }

  Widget getFormByStage(stage) {
    if (stage == 0) {
      return NameForm(entered: (input) {
        setState(() {
          _stage = 1;
          _name = input;
          texts[1][0] += '$_name!';
          children = [getAnimatedTextKitByStage(_stage)];
        });
      });
    } else if (stage == 1) {
      return AgeForm(entered: (input) {
        setState(() {
          _stage = 2;
          _age = input;
          children = [getAnimatedTextKitByStage(_stage)];
        });
      });
    } else if (stage == 2) {
      return Container(
          margin: const EdgeInsets.only(top: 8.0),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
              onPressed: () {
                widget.passed(_name, _age);
              },
              child: const Text('Поехали!')));
    } else {
      return Text('That`s all');
    }
  }
}

class NameForm extends StatefulWidget {
  final Function(String) entered;

  const NameForm({required this.entered, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
            ),
            Container(
              child: ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    String input = textController.text;
                    if (isCorrectName(input)) {
                      widget.entered(input[0].toUpperCase() +
                          input.substring(1).toLowerCase());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Пожалуйста, введите имя!')));
                    }
                  }),
              margin: const EdgeInsets.only(top: 8.0),
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
  }

  bool isCorrectName(String name) {
    return RegExp(r'[а-яА-Я\w]{2,}').hasMatch(name);
  }
}

class AgeForm extends StatefulWidget {
  final Function(int) entered;

  const AgeForm({required this.entered, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AgeFormState();
}

class _AgeFormState extends State<AgeForm> {
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: textController,
            ),
            Container(
              child: ElevatedButton(
                  child: Text('OK'),
                  onPressed: () {
                    String input = textController.text;
                    int age = isCorrectAge(input);
                    if (age != 0) {
                      widget.entered(age);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Пожалуйста, введите возраст!')));
                    }
                  }),
              margin: const EdgeInsets.only(top: 8.0),
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
  }

  int isCorrectAge(String input) {
    try {
      int num = int.parse(input);
      if (0 < num && num < 120) {
        return num;
      }
      return 0;
    } catch (err) {
      return 0;
    }
  }
}
