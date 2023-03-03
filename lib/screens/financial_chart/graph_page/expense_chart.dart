import 'package:flutter/material.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ExpensesChart extends StatefulWidget {
  const ExpensesChart({super.key});

  @override
  State<ExpensesChart> createState() => _ExpensesChartState();
}

class _ExpensesChartState extends State<ExpensesChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDB>(builder: ((context, value, child) {
      var allExpenseData = value.doughnutChartNotifier
          .where((element) => element.category.type == CategoryType.expense)
          .toList();
      return allExpenseData.isEmpty
          ? SizedBox(
              height: 20,
              child: Image.asset("asset/25943-nodata.gif", height: 30),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SfCircularChart(
                  legend: Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap),
                  series: <CircularSeries>[
                    DoughnutSeries<TransactionModel, String>(
                        // innerRadius: "105",
                        dataSource: allExpenseData,
                        xValueMapper: (TransactionModel data, _) =>
                            data.category.name,
                        yValueMapper: (TransactionModel data, _) => data.amount,
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true)),
                  ],
                ),
              ],
            );
    }));
  }
}
















//  Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           CircularPercentIndicator(
//             radius: 100,
//             lineWidth: 20,
//             percent: 0.4,
//             progressColor: Colors.deepPurple,
//             backgroundColor: Colors.deepPurple.shade100,
//             circularStrokeCap: CircularStrokeCap.round,
//             center: const Text(
//               "Rs 19987",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: LinearPercentIndicator(
//               barRadius: Radius.circular(10),
//               lineHeight: 20,
//               percent: 0.6,
//               progressColor: Colors.deepPurple,
//               backgroundColor: Colors.deepPurple[100],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: LinearPercentIndicator(
//               barRadius: Radius.circular(10),
//               lineHeight: 20,
//               percent: 0.6,
//               progressColor: Colors.deepPurple,
//               backgroundColor: Colors.deepPurple[100],
//             ),
//           ),
//         ],
//       ),
//     );