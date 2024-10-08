import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List HistorySampah;
  const MyBarGraph({super.key, required this.HistorySampah});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        senin: HistorySampah[0],
        selasa: HistorySampah[1],
        rabu: HistorySampah[2],
        kamis: HistorySampah[3],
        jumat: HistorySampah[4],
        sabtu: HistorySampah[5],
        minggu: HistorySampah[6]
    );
    myBarData.initializedBarData();

    return BarChart(
        BarChartData(
          maxY: 10,
          minY: 0,
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
              show: true,
              topTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false
                  )
              ),
              leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true
                  )
              ),
              rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: false
                  )
              ),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getBottomTitles
                  )
              )
          ),
          barGroups: myBarData.barData
              .map(
                (data) => BarChartGroupData(
              x: data.x,
              barRods: [BarChartRodData(
                  toY: data.y,
                  color: Colors.black,
                  width: 20,
                  borderRadius: BorderRadius.circular(4),
                  backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 10,
                      color: Colors.grey[200]
                  )
              ),
              ],
            ),
          )
              .toList(),
        )
    );
  }
}

Widget getBottomTitles (double value, TitleMeta meta) {
  const style = TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('Sen', style: style);
      break;
    case 1:
      text = const Text('Sel', style: style);
      break;
    case 2:
      text = const Text('Rab', style: style);
      break;
    case 3:
      text = const Text('Kam', style: style);
      break;
    case 4:
      text = const Text('Jum', style: style);
      break;
    case 5:
      text = const Text('Sab', style: style);
      break;
    case 6:
      text = const Text('Min', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
      child: text,
      axisSide: meta.axisSide);
}