import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:excel/excel.dart';

class AlgorithmScreen extends StatefulWidget {
  @override
  _AlgorithmScreenState createState() => _AlgorithmScreenState();
}

class _AlgorithmScreenState extends State<AlgorithmScreen> {
  int totalQtyBought = 0;
  int totalQtySold = 0;
  double avgBoughtPrice = 0.0;
  int totalBought = 0;
  double avgSoldPrice = 0.0;
  int totalSold = 0;

  @override
  void didChangeDependencies() {
    readExcelFile('SaudaBookTrades.xlsx');
    super.didChangeDependencies();
  }

  void readExcelFile(String fileName) async {
    ByteData data = await rootBundle.load("assets/$fileName");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    int j = 0;

    for (var table in excel.tables.keys) {
      //sheet Name
      for (var row in excel.tables[table].rows) {
        if (row[0] == 'BUYER') {
          totalQtyBought += int.parse(row[8]);
          if (row[12] == null) row[12] = row[11];
          totalBought += (int.parse(row[12]) * int.parse(row[8]));
        }
        if (row[0] == 'SELLER') {
          totalQtySold += int.parse(row[8]);
          if (row[12] == null) row[12] = row[11];
          totalSold += (int.parse(row[12]) * int.parse(row[8]));
        }
      }
    }
    avgBoughtPrice = totalBought / totalQtyBought;
    avgSoldPrice = totalSold / totalQtySold;
    print(totalQtyBought);
    print(totalQtySold);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: size.height / 10),
        child: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            descriptionCard(
                context, totalQtyBought.toString(), "Total Quantity Bought"),
            descriptionCard(
                context, totalQtySold.toString(), "Total Quantity Sold"),
            descriptionCard(context, "INR ${avgBoughtPrice.toString()}",
                "Average Bought Price"),
            descriptionCard(
                context, "INR ${avgSoldPrice.toString()}", "Average Sold Price")
          ],
        ),
      ),
    );
  }

  Widget descriptionCard(context, String text, String value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.bodyText1,
                    ))),
            Center(
                child: Card(
                    elevation: 2,
                    color: Colors.amberAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          text,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
