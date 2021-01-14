import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class GraficoIMC extends StatelessWidget {
  GraficoIMC({this.imc});

  double imc;

  List<Series<MedidaIMC, String>> chartData;

  @override
  Widget build(BuildContext context) {
    chartData = [
      Series<MedidaIMC, String>(
          id: "IMC",
          data: [
            MedidaIMC(descricao: "Min ideal", imc: 18.5),
            MedidaIMC(descricao: "Seu IMC", imc: imc),
            MedidaIMC(descricao: "Max ideal", imc: 24.9),
          ],
          domainFn: (item, _) => item.descricao,
          measureFn: (item, _) => item.imc)
    ];
    return BarChart(chartData, animate: true);
  }

  /// Create one series with sample hard coded data.

}

class MedidaIMC {
  final String descricao;
  final double imc;
  const MedidaIMC({this.descricao, this.imc});
}
