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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Neumorphic(
                          child: Padding(
                            padding: const EdgeInsets.all(36),
                            child: Text(
                              "789456123456798",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(fontSize: 16),
                            ),
                          ),
                          style: NeumorphicStyle(
                              intensity: 2,
                              depth: -16,
                              color: Color(0xFF77AA99)),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotaoCalculadora(digito: 7),
                          BotaoCalculadora(digito: 8),
                          BotaoCalculadora(digito: 9)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotaoCalculadora(digito: 4),
                          BotaoCalculadora(digito: 5),
                          BotaoCalculadora(digito: 6)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BotaoCalculadora(digito: 1),
                          BotaoCalculadora(digito: 2),
                          BotaoCalculadora(digito: 3)
                        ],
                      )
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

  final int digito;
  final Function() pressionouTecla;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(6.0),
        child: NeumorphicButton(
            style: NeumorphicStyle(
                depth: 8, boxShape: NeumorphicBoxShape.circle()),
            onPressed: () {
              if (pressionouTecla != null) pressionouTecla();
            },
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(digito.toString()),
            )),
      );
}
