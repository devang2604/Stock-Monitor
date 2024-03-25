import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:crypto_api/constants.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double heightOne = MediaQuery.of(context).size.height;
    double widthOne = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widthOne * 0.06,
        vertical: heightOne * 0.02,
      ),
      child: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: heightOne * 0.05,
                child: Image.network(item.image),
              ),
            ),
            SizedBox(width: widthOne * 0.03),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.id,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "0.4" + item.symbol,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: widthOne * 0.005,
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: heightOne * 0.03,
                // width: widthOne * 0.2,
                child: Sparkline(
                  data: item.sparklineIn7D.price,
                  lineWidth: 2.0,
                  lineColor: item.marketCapChangePercentage24H >= 0
                      ? kgreen
                      : Colors.red,
                  fillMode: FillMode.below,
                  fillGradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.7],
                    colors: item.marketCapChangePercentage24H >= 0
                        ? [
                            kgreen,
                            kgreen.withOpacity(0.2),
                          ]
                        : [
                            Colors.red,
                            Colors.red.shade100,
                          ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: widthOne * 0.05,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '\$ ' + item.currentPrice.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        item.priceChange24H.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: widthOne * 0.03),
                      Text(
                        item.marketCapChangePercentage24H.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
