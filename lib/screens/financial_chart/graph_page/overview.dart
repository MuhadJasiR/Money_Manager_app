import 'package:flutter/material.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// List<TransactionModel> doughnutChartNotifier =
//     TransactionDB.instance.transactionListNotifier;

class OverviewChart extends StatefulWidget {
  const OverviewChart({super.key});

  @override
  State<OverviewChart> createState() => _OverviewChartState();
}

class _OverviewChartState extends State<OverviewChart> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<TransactionDB>(context).doughnutChartNotifier;
    return Consumer<TransactionDB>(builder: ((context, value, child) {
      Map incomeMap = {"name": "Income", "amount": value.incomeTotal};
      Map expenseMap = {"name": "Expense", "amount": value.expenseTotal};
      List<Map> dataList = [incomeMap, expenseMap];
      return value.doughnutChartNotifier.isEmpty
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
                      overflowMode: LegendItemOverflowMode.scroll),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<Map, String>(
                      dataSource: dataList,
                      xValueMapper: (Map data, _) => data['name'],
                      yValueMapper: (Map data, _) => data['amount'],
                      enableTooltip: true,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                    )
                  ],
                ),
              ],
            );
    }));
  }
}
