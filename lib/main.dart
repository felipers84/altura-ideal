import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:imc/calculadora.cubit.dart';
import 'package:imc/calculadora.dart';
import 'package:imc/introducao.dart';
import 'package:imc/resultado.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'IMC Releitura',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.red),
            bodyText2: TextStyle(
                color: Color(0xFF555555), fontWeight: FontWeight.bold),
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
  final String unidade = "cm";
  final String placeholder = "Informe o peso";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String display = "";

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
  Widget build(BuildContext context) => BlocProvider<CalculadoraCubit>(
        create: (context) => CalculadoraCubit(),
        child: Scaffold(
            backgroundColor: NeumorphicColors.background,
            body: SafeArea(
              maintainBottomViewPadding: false,
              child: Container(
                color: NeumorphicColors.background,
                child: LayoutBuilder(
                  builder: (context, constraints) => Center(
                    child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: constraints.maxWidth / 8),
                        child: BlocBuilder<CalculadoraCubit, CalculadoraState>(
                          builder: (context, state) {
                            var cubit =
                                BlocProvider.of<CalculadoraCubit>(context);
                            if (state is CalculadoraState_Introducao) {
                              return Introducao();
                            } else if (state
                                is CalculadoraState_VerificandoPeso)
                              return Calculadora(
                                key: GlobalKey(),
                                placeholder: "Informe o peso",
                                unidade: "kg",
                                valorInformado: (valor) =>
                                    cubit.verificarAltura(valor),
                              );
                            else if (state
                                is CalculadoraState_VerificandoAltura)
                              return Calculadora(
                                  key: GlobalKey(),
                                  placeholder: "Informe a altura",
                                  unidade: "cm",
                                  valorInformado: (valor) =>
                                      cubit.calcularIMC(valor));
                            else if (state
                                is CalculadoraState_ExibindoResultado)
                              return Resultado(state: state);
                            return Container();
                          },
                        )),
                  ),
                ),
              ),
            ) // This trailing comma makes auto-formatting nicer for build methods.
            ),
      );
}
