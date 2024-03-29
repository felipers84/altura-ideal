import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Calculadora extends StatefulWidget {
  const Calculadora(
      {Key key,
      this.title,
      this.valorInformado,
      this.unidade = "cm",
      this.placeholder = "Informe um valor"})
      : super(key: key);

  final String title;
  final String unidade;
  final String placeholder;
  final Function(int) valorInformado;

  @override
  _Calculadora createState() => _Calculadora();
}

class _Calculadora extends State<Calculadora> with TickerProviderStateMixin {
  String display = "";
  AnimationController opacityController;

  @override
  void initState() {
    opacityController = AnimationController(
        duration: Duration(milliseconds: 500), value: 0, vsync: this)
      ..animateTo(1, curve: Curves.easeInOut);
  }

  close() {
    opacityController
        .animateTo(0, duration: Duration(milliseconds: 300))
        .then((value) {
      if (widget.valorInformado != null)
        widget.valorInformado(int.parse(display));
    });
    opacityController.animateTo(0, curve: Curves.easeInOut);
  }

  pressionouDigito(String digito) {
    if (display.length < 3) {
      setState(() => display = "${display}${digito}");
    }
  }

  limparDigito() {
    if (display.length >= 1) {
      setState(() => display = display.substring(0, display.length - 1));
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => Center(
          child: AnimatedBuilder(
            animation: opacityController,
            builder: (context, _) => Opacity(
              opacity: opacityController.value,
              child: Neumorphic(
                style: NeumorphicStyle(
                    shape: NeumorphicShape.concave,
                    depth: 12,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.all(Radius.circular(24)))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("ALTURA IDEAL",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF999999),
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic)),
                          SizedBox(width: 8),
                          Image.asset('assets/icone.png', width: 24),
                        ],
                      ),
                      SizedBox(height: 8),
                      Neumorphic(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 100,
                              child: Center(
                                child: Text(
                                  display == "" ? widget.placeholder : display,
                                  textAlign: TextAlign.right,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                          fontSize: display == "" ? 24 : 48),
                                ),
                              ),
                            ),
                            display == ""
                                ? Container()
                                : Positioned(
                                    bottom: 14,
                                    child: Text(
                                      widget.unidade,
                                      style: TextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 12),
                                    ),
                                  )
                          ],
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
                      SizedBox(height: 12),
                      BotaoCalculadora(
                          digito: "0",
                          pressionouTecla: () => pressionouDigito("0")),
                      SizedBox(height: 24),
                      NeumorphicButton(
                        style: NeumorphicStyle(
                            depth: 12,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(8))),
                        onPressed: () {
                          if (int.tryParse(display) != null) close();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "PROSSEGUIR",
                            style: TextStyle(fontWeight: FontWeight.w800),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ); // This trailing comma makes auto-formatting nicer for build methods.

}

class BotaoCalculadora extends StatelessWidget {
  const BotaoCalculadora({Key key, this.digito, this.pressionouTecla})
      : super(key: key);

  final String digito;
  final Function() pressionouTecla;

  @override
  Widget build(BuildContext context) => NeumorphicButton(
      style: NeumorphicStyle(
          depth: 8,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10.0))),
      onPressed: () {
        if (pressionouTecla != null) pressionouTecla();
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Text(digito),
      ));
}
