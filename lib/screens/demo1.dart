import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Orientationbuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Business Dashboard')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                Expanded(child: RevenueChart()),
                Expanded(child: RevenueStats()),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(child: RevenueChart()),
                VerticalDivider(width: 1),
                Expanded(child: RevenueStats()),
              ],
            );
          }
        },
      ),
    );
  }
}

class RevenueChart extends StatelessWidget {
  final List<double> revenues = [1500, 1800, 1400, 2000, 1700, 2200, 1950];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 2500,
            barTouchData: BarTouchData(enabled: true),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = [
                      'Mon',
                      'Tue',
                      'Wed',
                      'Thu',
                      'Fri',
                      'Sat',
                      'Sun',
                    ];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        days[value.toInt() % days.length],
                        style: TextStyle(fontSize: 12),
                      ),
                    );
                  },
                  interval: 1,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(show: true),
            borderData: FlBorderData(show: false),
            barGroups: List.generate(revenues.length, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: revenues[i],
                    color: Colors.lightBlue,
                    width: 18,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class RevenueStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.green[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Doanh thu hôm nay: \$1,250', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Khách hàng mới: 32', style: TextStyle(fontSize: 18)),
          SizedBox(height: 10),
          Text('Đơn hàng thành công: 76', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
