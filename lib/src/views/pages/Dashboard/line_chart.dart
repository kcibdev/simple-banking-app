import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simplebankingapp/src/models/transaction.model.dart';

LineChartData mainData(List<TransactionModel> transaction) {
  //map day of the week with value as numbers
  Map<String, double> dayMap = {
    'Monday': 1.0,
    'Tuesday': 2.0,
    'Wednesday': 3.0,
    'Thursday': 4.0,
    'Friday': 5.0,
    'Saturday': 6.0,
    'Sunday': 7.0,
  };
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Colors.transparent,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Colors.transparent,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true, border: Border.all(color: Colors.transparent, width: 1)),
    minX: 0,
    maxX: 7,
    minY: 0,
    maxY: 10000,
    lineBarsData: [
      LineChartBarData(
        spots: transaction.map((tr) {
          if (tr.created == null || tr.amount == null) {
            return const FlSpot(0, 0);
          }
          return FlSpot(
            dayMap[DateFormat('EEEE').format(tr.created!)]!,
            tr.amount!.toDouble(),
          );
        }).toList(),
        isCurved: false,
        gradient: const LinearGradient(
          colors: [
            Color(0xffffffff),
            Color(0xffffffff),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              const Color(0xffffffff),
              const Color(0xffffffff),
            ].map((color) => color.withOpacity(0.3)).toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ],
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 1:
      text = const Text('Mon', style: style);
      break;
    case 2:
      text = const Text('Tue', style: style);
      break;
    case 3:
      text = const Text('Wed', style: style);
      break;
    case 4:
      text = const Text('Thu', style: style);
      break;
    case 5:
      text = const Text('Fri', style: style);
      break;
    case 6:
      text = const Text('Sat', style: style);
      break;
    case 7:
      text = const Text('Sun', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xffffffff),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  switch (value.toInt()) {
    case 0:
      text = '0K';
      break;
    case 2000:
      text = '2k';
      break;
    case 4000:
      text = '4k';
      break;
    case 6000:
      text = '6k';
      break;
    case 8000:
      text = '8k';
      break;
    case 10000:
      text = '10k';
      break;
    default:
      return Container();
  }

  return Text(text, style: style, textAlign: TextAlign.left);
}
