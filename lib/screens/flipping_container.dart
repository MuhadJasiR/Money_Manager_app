import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_manager_app/db/transaction_db.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FlippingContainer extends StatelessWidget {
  FlippingContainer({super.key});

  late FlipCardController flipCardController;

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   flipCardController = FlipCardController();
    // });
    flipCardController = FlipCardController();
    Size size = MediaQuery.of(context).size;
    return FlipCard(
        direction: FlipDirection.VERTICAL,
        flipOnTouch: true,
        controller: flipCardController,
        front: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 47, 137, 255),
          ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
            height: 210,
            width: size.width > size.height ? size.width / 2 : size.width - 40,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.arrow_circle_up_sharp,
                                color: Colors.white,
                                size: 75,
                              ),
                              const Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Consumer<TransactionDB>(
                                  builder: ((context, value, child) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    value.incomeTotal.toString(),
                                    style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }))
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.arrow_circle_down,
                            color: Colors.white,
                            size: 75,
                          ),
                          const Text(
                            "Expenses",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Consumer<TransactionDB>(
                              builder: ((context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                value.expenseTotal.toString(),
                                style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }))
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Tap to rotate",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
        back: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 47, 137, 255),
          ),
          child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(30)),
              height: 210,
              width:
                  size.width > size.height ? size.width / 2 : size.width - 40,
              child: Consumer<TransactionDB>(builder: ((context, value, child) {
                Map incomeMap = {
                  "name": "Income",
                  "amount": Provider.of<TransactionDB>(context).incomeTotal
                };
                Map expenseMap = {
                  "name": "Expense",
                  "amount": Provider.of<TransactionDB>(context).expenseTotal
                };
                List<Map> dataList = [incomeMap, expenseMap];
                return value.doughnutChartNotifier.isEmpty
                    ? Center(
                        child: Text(
                        "No data found . . !",
                        style: GoogleFonts.coiny(
                            fontSize: 20, color: Colors.white),
                      ))
                    : FittedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SfCircularChart(
                              //   title: ChartTitle(text: 'Statistics'),
                              legend: Legend(
                                  isVisible: false,
                                  overflowMode: LegendItemOverflowMode.scroll),
                              // tooltipBehavior: _tooltipBehavior,
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
                        ),
                      );
              }))),
        ));
  }
}
