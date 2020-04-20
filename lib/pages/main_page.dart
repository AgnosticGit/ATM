import 'package:ATM/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:ATM/components/waves.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<int> _bills = [];
  var _result;
  final TextEditingController sumController = TextEditingController();
  final String error = 'Банкомат не может выдать, запрашиваемую сумму';

  @override
  void initState() {
    super.initState();
    initBills();
  }

  void initBills() {
    int oneHundredCount = 50;
    int twoHundredCount = 100;
    int fiveHundredCount = 100;
    int oneThousandCount = 10;
    int twoThousandCount = 100;
    int fiveThousandCount = 10;

    initBillsCycle(oneHundredCount, 100);
    initBillsCycle(twoHundredCount, 200);
    initBillsCycle(fiveHundredCount, 500);
    initBillsCycle(oneThousandCount, 1000);
    initBillsCycle(twoThousandCount, 2000);
    initBillsCycle(fiveThousandCount, 5000);
  }

  initBillsCycle(count, billType) {
    while (count != 0) {
      _bills.add(billType);
      count--;
    }
  }

  getSum() {
    String text = sumController.text;
    String filter = text.replaceAll(new RegExp(r'\d'), '');

    if (filter.length != 0 || text.length == 0) {
      setState(() {
        _result = error;
      });
      return;
    }

    double initSum = double.parse(text);
    double sum = double.parse(text);
    List<int> resultList = [];
    List<int> billsCopy = [..._bills];
    List<int> billTypes = [5000, 2000, 1000, 500, 200, 100];

    if (sum % 100 != 0) {
      setState(() {
        _result = error;
      });
      return;
    }

    billTypes.forEach((element) {
      while (sum >= element) {
        if (billsCopy.contains(element)) {
          resultList.add(element);
          billsCopy.remove(element);
          sum = sum - element;
        } else {
          break;
        }
      }
    });

    if (resultList.reduce((x, y) => x + y) == initSum) {
      setState(() {
        _bills = billsCopy;
        _result = resultList;
      });
    } else {
      setState(() {
        _result = error;
      });
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: CustomPaint(
        painter: Waves(),
        child: Column(
          children: <Widget>[
            SizedBox(height: 28),
            Expanded(
                flex: 10,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Sum(sumController), Button(getSum)],
                  ),
                )),
            SizedBox(height: 22),
            Decorator(),
            Expanded(
              flex: 6,
              child: Container(
                child: Balance(
                  _result,
                  'Банкомат выдал следующие купюры',
                ),
              ),
            ),
            Decorator(),
            Expanded(
              flex: 6,
              child: Container(
                child: Balance(_bills, 'Баланс банкомата'),
              ),
            ),
            Decorator(),
            Expanded(
              flex: 7,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    sumController.dispose();
    super.dispose();
  }
}

class Sum extends StatelessWidget {
  Sum(this.sumController);

  final TextEditingController sumController;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.5,
      child: Column(
        children: [
          Text(
            'Введите сумму',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Container(
            child: TextField(
              textAlign: TextAlign.center,
              controller: sumController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 30),
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
          Container(
            width: width * 0.45,
            height: 1,
            color: Colors.white.withOpacity(0.3),
          )
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button(this.getSum);
  Function getSum;

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: ButtonTheme(
        minWidth: width * 0.6,
        height: 60,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(50.0),
          ),
          onPressed: () => {getSum()},
          color: CustomColors.pink,
          child: Text(
            'Выдать сумму',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class Balance extends StatelessWidget {
  Balance(this.bills, this.title);
  String title;
  var bills;

  onCountBills(int billType) {
    if (bills is List) {
      String count =
          bills.where((x) => x == billType).toList().length.toString();
      return count + ' X ' + billType.toString() + ' рублей';
    } else {
      return '';
    }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (bills == null) {
      return Container();
    }

    if (bills is String) {
      return Container(
        width: width * 0.8,
        alignment: Alignment.center,
        child: Text(
          bills,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: CustomColors.pink,
          ),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: CustomColors.grayA3,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      // alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BalanceText(onCountBills(100)),
                          BalanceText(onCountBills(200)),
                          BalanceText(onCountBills(2000)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BalanceText(onCountBills(500)),
                          BalanceText(onCountBills(1000)),
                          BalanceText(onCountBills(5000)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}

class BalanceText extends StatelessWidget {
  BalanceText(this.text);
  String text;

  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: CustomColors.deepBlue),
    );
  }
}

class Decorator extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      color: CustomColors.lightGray,
    );
  }
}
