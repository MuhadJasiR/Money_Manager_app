// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:money_manager_app/models/transacrtion_model.dart';
import 'package:money_manager_app/models/category_modal.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Income_chart extends StatefulWidget {
  const Income_chart({super.key});

  @override
  State<Income_chart> createState() => _Income_chartState();
}

class _Income_chartState extends State<Income_chart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionDB>(builder: ((context, value, child) {
      var allIncomeData = value.doughnutChartNotifier
          .where((element) => element.category.type == CategoryType.income)
          .toList();
      return allIncomeData.isEmpty
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
                        dataSource: allIncomeData,
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
