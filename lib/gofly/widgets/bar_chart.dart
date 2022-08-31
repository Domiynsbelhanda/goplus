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
                    rod.y.round().toString(),
                    TextStyle(color: Colors.black, fontSize: 10),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) =>
                    const TextStyle(color: Colors.grey, fontSize: 10),
                margin: 5,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Sep';
                    case 1:
                      return 'Oct';
                    case 2:
                      return 'Nov';
                    case 3:
                      return 'Dec';
                    case 4:
                      return 'Jan';
                    case 5:
                      return 'Feb';
                    case 6:
                      return 'Sn';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
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
                    y: 10,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
                    y: 12,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
                    y: 14,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
                    y: 8,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
                    y: 5,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
                    y: 15,
                    colors: [Color(0xfff8f8f8), Colors.white],
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
