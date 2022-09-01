import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AspectRatio(
      aspectRatio: 2.5,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                  BarChartGroupData group,
                  int groupIndex,
                  BarChartRodData rod,
                  int rodIndex,
                ) {
                  return BarTooltipItem(
                    rod.toY.round().toString(),
                    TextStyle(color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
            // titlesData: FlTitlesData(
            //   show: true,
            //   bottomTitles: AxisTitles(
            //     sideTitles: true,
            //     getTextStyles: (value) =>
            //         const TextStyle(color: Colors.grey, fontSize: 10),
            //     margin: 5,
            //     getTitles: (double value) {
            //       switch (value.toInt()) {
            //         case 0:
            //           return 'Sep';
            //         case 1:
            //           return 'Oct';
            //         case 2:
            //           return 'Nov';
            //         case 3:
            //           return 'Dec';
            //         case 4:
            //           return 'Jan';
            //         case 5:
            //           return 'Feb';
            //         case 6:
            //           return 'Sn';
            //         default:
            //           return '';
            //       }
            //     },
            //   ),
            //   leftTitles: AxisTitles(),
            // ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 10,
                    color: Color(0xfff8f8f8),
                    toY: 0.0,
                  )
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 12,
                    color: Color(0xfff8f8f8), toY: 0.0,
                  )
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 14,
                    color: Color(0xfff8f8f8),
                    toY: 0.0
                  )
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 8,
                    color: Color(0xfff8f8f8),
                    toY: 0.0
                  )
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 4,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 5,
                    toY: 0.0,
                    color: Color(0xfff8f8f8),
                  )
                ],
                showingTooltipIndicators: [0],
              ),
              BarChartGroupData(
                x: 5,
                barRods: [
                  BarChartRodData(
                    width: size.width * 0.12,
                    borderRadius: BorderRadius.zero,
                    fromY: 15,
                    toY: 0.0,
                    color: Color(0xfff8f8f8),
                  )
                ],
                showingTooltipIndicators: [0],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
