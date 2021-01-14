import 'package:flutter_bloc/flutter_bloc.dart';

class CalculadoraCubit extends Cubit<CalculadoraState> {
  CalculadoraCubit() : super(CalculadoraState_VerificandoPeso());
}

abstract class CalculadoraState {}

class CalculadoraState_VerificandoPeso extends CalculadoraState {}

class CalculadoraState_VerificandoAltura extends CalculadoraState {}

class CalculadoraState_ExibindoResultado extends CalculadoraState {
  int peso;
  int altura;
  CalculadoraState_ExibindoResultado({this.peso, this.altura});
}
