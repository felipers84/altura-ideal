import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'calculadora.cubit.dart';
import 'grafico.dart';

class Resultado extends StatelessWidget {
  const Resultado({Key key, this.state}) : super(key: key);

  final CalculadoraState_ExibindoResultado state;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
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
            Text("Seu resultado:",
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 24),
            Container(
                width: 200, height: 200, child: GraficoIMC(imc: state.imc)),
            SizedBox(height: 24),
            Text(
              state.tipoacao == ETipoAcao.Nada
                  ? "Você está em sua altura ideal!"
                  : "Para alcançar a sua altura ideal, você precisa:",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ...state.tipoacao == ETipoAcao.Nada
                ? [Container()]
                : [
                    LabelAcao(state: state),
                    SizedBox(height: 12),
                    Text("${(state.deltaAlturaParaIMCIdeal * 100).round()}cm !",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24)),
                    SizedBox(height: 24)
                  ],
            NeumorphicButton(
              onPressed: () =>
                  BlocProvider.of<CalculadoraCubit>(context).verificarPeso(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "REFAZER O TESTE!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LabelAcao extends StatelessWidget {
  const LabelAcao({
    Key key,
    @required this.state,
  }) : super(key: key);

  final CalculadoraState_ExibindoResultado state;

  @override
  Widget build(BuildContext context) {
    return Text(
      state.tipoacao == ETipoAcao.Crescer
          ? "CRESCER"
          : state.tipoacao == ETipoAcao.Encolher
              ? "ENCOLHER"
              : "",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 36),
    );
  }
}
