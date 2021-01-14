import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Releitura',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.red),
            bodyText2: TextStyle(color: Color(0xFF777777)),
            bodyText1: TextStyle(fontFamily: "Digital")),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = "";

  pressionouDigito(String digito) {
    if (digito.length < 3) {
      setState(() => display = "${display}${digito}");
    }
  }

  limparDigito() {
    if (display.length >= 1) {
      setState(() => display = display.substring(0, display.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        color: NeumorphicColors.background,
        child: LayoutBuilder(
          builder: (context, constraints) => Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: constraints.maxWidth / 6),
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(24)))),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Neumorphic(
                        child: Padding(
                          padding: const EdgeInsets.all(28),
                          child: Text(
                            display == "" ? "Informe o peso" : display,
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 32),
                          ),
                        ),
                        style: NeumorphicStyle(
                            intensity: 2,
                            depth: -16,
                            color: Color(0xFF77AA99),
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.all(Radius.circular(6)))),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BotaoCalculadora(
                              digito: "<",
                              pressionouTecla: () => limparDigito())
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["7", "8", "9"]
                              .map((e) => BotaoCalculadora(
                                  digito: e,
                                  pressionouTecla: () => pressionouDigito(e)))
                              .toList()),
                      SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["4", "5", "6"]
                              .map((e) => BotaoCalculadora(
                                  digito: e,
                                  pressionouTecla: () => pressionouDigito(e)))
                              .toList()),
                      SizedBox(height: 12),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ["1", "2", "3"]
                              .map((e) => BotaoCalculadora(
                                  digito: e,
                                  pressionouTecla: () => pressionouDigito(e)))
                              .toList()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class BotaoCalculadora extends StatelessWidget {
  const BotaoCalculadora({Key key, this.digito, this.pressionouTecla})
      : super(key: key);

  final String digito;
  final Function() pressionouTecla;

  @override
  Widget build(BuildContext context) => NeumorphicButton(
      style: NeumorphicStyle(depth: 8, boxShape: NeumorphicBoxShape.circle()),
      onPressed: () {
        if (pressionouTecla != null) pressionouTecla();
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(digito),
      ));
}
