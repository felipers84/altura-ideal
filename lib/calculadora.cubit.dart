import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class CalculadoraCubit extends Cubit<CalculadoraState> {
  CalculadoraCubit() : super(CalculadoraState_Introducao());

  int peso;
  double altura;

  verificarPeso() => emit(CalculadoraState_VerificandoPeso());

  verificarAltura(int pesoInformado) {
    peso = pesoInformado;
    emit(CalculadoraState_VerificandoAltura());
  }

  calcularIMC(int alturaInformada) {
    altura = alturaInformada / 100;
    var imc = (peso / pow((altura), 2));
    var alturaIdealMaxima = sqrt(peso / 18.5);
    var alturaIdealMinima = sqrt(peso / 24.9);

    if (altura < alturaIdealMinima) {
      emit(CalculadoraState_ExibindoResultado(
          imc: imc,
          tipoacao: ETipoAcao.Crescer,
          deltaAlturaParaIMCIdeal: alturaIdealMinima - altura));
    } else if (altura <= alturaIdealMaxima) {
      emit(CalculadoraState_ExibindoResultado(
          imc: imc, tipoacao: ETipoAcao.Nada, deltaAlturaParaIMCIdeal: 0));
    } else {
      emit(CalculadoraState_ExibindoResultado(
          imc: imc,
          tipoacao: ETipoAcao.Encolher,
          deltaAlturaParaIMCIdeal: altura - alturaIdealMaxima));
    }
  }
}

abstract class CalculadoraState {}

class CalculadoraState_Introducao extends CalculadoraState {}

class CalculadoraState_VerificandoPeso extends CalculadoraState {}

class CalculadoraState_VerificandoAltura extends CalculadoraState {}

class CalculadoraState_ExibindoResultado extends CalculadoraState {
  double imc;
  ETipoAcao tipoacao;
  double deltaAlturaParaIMCIdeal;
  CalculadoraState_ExibindoResultado(
      {this.deltaAlturaParaIMCIdeal, this.imc, this.tipoacao});
}

enum ETipoAcao { Crescer, Encolher, Nada }
