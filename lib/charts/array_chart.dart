import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ArrayChart extends StatefulWidget {
  const ArrayChart({Key? key}) : super(key: key);

  @override
  State<ArrayChart> createState() => _ArrayChartState();
}

class _ArrayChartState extends State<ArrayChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  BarChartGroupData makeGroupData(String x, double y1) {
    return BarChartGroupData(barsSpace: 4, x: x as int, barRods: [
      BarChartRodData(
        toY: y1,
        colors: [leftBarColor],
        width: width,
      ),
    ]);
  }

  // Data[{“22 March”,3},{“22 March”,4},{“23 March”,1},{“23 March”,6},{“24 March”,2},]

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData('1 mar', 5);
    final barGroup2 = makeGroupData('1 mar', 16);
    final barGroup3 = makeGroupData('2 mar', 18);
    final barGroup4 = makeGroupData('3 mar', 20);
    final barGroup5 = makeGroupData('4 mar', 17);
    final barGroup6 = makeGroupData('5 mar', 19);
    final barGroup7 = makeGroupData('6 mar', 10);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 400,
            width: 400,
            child: BarChart(
              BarChartData(
                maxY: 20,
                barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (_a, _b, _c, _d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (var rod
                              in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum /
                              showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex]
                                .barRods
                                .map((rod) {
                              return rod.copyWith(toY: avg);
                            }).toList(),
                          );
                        }
                      });
                    }),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: SideTitles(showTitles: false),
                  topTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    margin: 20,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return '1 Mar';
                        case 1:
                          return '2 Mar';
                        case 2:
                          return '3 Mar';
                        case 3:
                          return '4 Mar';
                        case 4:
                          return '5 Mar';
                        case 5:
                          return '6 Mar';
                        case 6:
                          return '7 Mar';
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                    showTitles: true,
                    getTextStyles: (context, value) => const TextStyle(
                        color: Color(0xff7589a2),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    margin: 8,
                    reservedSize: 28,
                    interval: 1,
                    getTitles: (value) {
                      if (value == 0) {
                        return '1K';
                      } else if (value == 10) {
                        return '5K';
                      } else if (value == 19) {
                        return '10K';
                      } else {
                        return '';
                      }
                    },
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: showingBarGroups,
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class ArrayChart extends StatefulWidget {
//   const ArrayChart({Key? key}) : super(key: key);

//   @override
//   State<ArrayChart> createState() => _ArrayChartState();
// }

// class _ArrayChartState extends State<ArrayChart> {
//   final Color leftBarColor = const Color(0xff53fdd7);
//   final Color rightBarColor = const Color(0xffff5182);
//   final double width = 7;

//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups;

//   int touchedGroupIndex = -1;

//   BarChartGroupData makeGroupData(int x, double y1, double y2) {
//     return BarChartGroupData(barsSpace: 4, x: x, barRods: [
//       BarChartRodData(
//         toY: y1,
//         colors: [leftBarColor],
//         width: width,
//       ),
//       BarChartRodData(
//         toY: y2,
//         colors: [rightBarColor],
//         width: width,
//       ),
//     ]);
//   }

//   @override
//   void initState() {
//     super.initState();
//     final barGroup1 = makeGroupData(0, 5, 12);
//     final barGroup2 = makeGroupData(1, 16, 12);
//     final barGroup3 = makeGroupData(2, 18, 5);
//     final barGroup4 = makeGroupData(3, 20, 16);
//     final barGroup5 = makeGroupData(4, 17, 6);
//     final barGroup6 = makeGroupData(5, 19, 1.5);
//     final barGroup7 = makeGroupData(6, 10, 1.5);

//     final items = [
//       barGroup1,
//       barGroup2,
//       barGroup3,
//       barGroup4,
//       barGroup5,
//       barGroup6,
//       barGroup7,
//     ];

//     rawBarGroups = items;

//     showingBarGroups = rawBarGroups;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Expanded(
//             child: BarChart(
//               BarChartData(
//                 maxY: 20,
//                 barTouchData: BarTouchData(
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.grey,
//                       getTooltipItem: (_a, _b, _c, _d) => null,
//                     ),
//                     touchCallback: (FlTouchEvent event, response) {
//                       if (response == null || response.spot == null) {
//                         setState(() {
//                           touchedGroupIndex = -1;
//                           showingBarGroups = List.of(rawBarGroups);
//                         });
//                         return;
//                       }

//                       touchedGroupIndex = response.spot!.touchedBarGroupIndex;

//                       setState(() {
//                         if (!event.isInterestedForInteractions) {
//                           touchedGroupIndex = -1;
//                           showingBarGroups = List.of(rawBarGroups);
//                           return;
//                         }
//                         showingBarGroups = List.of(rawBarGroups);
//                         if (touchedGroupIndex != -1) {
//                           var sum = 0.0;
//                           for (var rod
//                               in showingBarGroups[touchedGroupIndex].barRods) {
//                             sum += rod.toY;
//                           }
//                           final avg = sum /
//                               showingBarGroups[touchedGroupIndex]
//                                   .barRods
//                                   .length;

//                           showingBarGroups[touchedGroupIndex] =
//                               showingBarGroups[touchedGroupIndex].copyWith(
//                             barRods: showingBarGroups[touchedGroupIndex]
//                                 .barRods
//                                 .map((rod) {
//                               return rod.copyWith(toY: avg);
//                             }).toList(),
//                           );
//                         }
//                       });
//                     }),
//                 titlesData: FlTitlesData(
//                   show: true,
//                   rightTitles: SideTitles(showTitles: false),
//                   topTitles: SideTitles(showTitles: false),
//                   bottomTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context, value) => const TextStyle(
//                         color: Color(0xff7589a2),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14),
//                     margin: 20,
//                     getTitles: (double value) {
//                       switch (value.toInt()) {
//                         case 0:
//                           return 'Mn';
//                         case 1:
//                           return 'Te';
//                         case 2:
//                           return 'Wd';
//                         case 3:
//                           return 'Tu';
//                         case 4:
//                           return 'Fr';
//                         case 5:
//                           return 'St';
//                         case 6:
//                           return 'Sn';
//                         default:
//                           return '';
//                       }
//                     },
//                   ),
//                   leftTitles: SideTitles(
//                     showTitles: true,
//                     getTextStyles: (context, value) => const TextStyle(
//                         color: Color(0xff7589a2),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14),
//                     margin: 8,
//                     reservedSize: 28,
//                     interval: 1,
//                     getTitles: (value) {
//                       if (value == 0) {
//                         return '1K';
//                       } else if (value == 10) {
//                         return '5K';
//                       } else if (value == 19) {
//                         return '10K';
//                       } else {
//                         return '';
//                       }
//                     },
//                   ),
//                 ),
//                 borderData: FlBorderData(
//                   show: false,
//                 ),
//                 barGroups: showingBarGroups,
//                 gridData: FlGridData(show: false),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

