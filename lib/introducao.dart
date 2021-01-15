import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imc/calculadora.cubit.dart';
import 'dart:math' as math;

class Introducao extends StatefulWidget {
  const Introducao({Key key}) : super(key: key);

  @override
  _IntroducaoState createState() => _IntroducaoState();
}

class _IntroducaoState extends State<Introducao> with TickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this)
          ..animateTo(1, curve: Curves.bounceOut);

    Future.delayed(Duration(seconds: 4)).then(
        (value) => BlocProvider.of<CalculadoraCubit>(context).verificarPeso());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, widget) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Transform.scale(
            alignment: Alignment.bottomLeft,
            scale: 0.1 + (0.9 * controller.value),
            child: Text(
              "ALTURA IDEAL",
              style: TextStyle(fontSize: 40, height: 0.8),
            ),
          ),
          Text(
            "por Felipe Campos",
            textAlign: TextAlign.start,
          )
        ],
      ),
    );
  }
}
