import 'package:crypto_api/constants.dart';
import 'package:flutter/material.dart';

class Item2 extends StatelessWidget {
  var item;
  Item2({this.item});

  @override
  Widget build(BuildContext context) {
    double heightOne = MediaQuery.of(context).size.height;
    double widthOne = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widthOne * 0.03,
        vertical: heightOne * 0.02,
      ),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: widthOne * 0.03, vertical: heightOne * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: heightOne * 0.035,
                child: Image.network(item.image),
              ),
              SizedBox(
                height: heightOne * 0.02,
              ),
              Text(
                item.id,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: heightOne * 0.01,
              ),
              Row(
                children: [
                  Text(
                    item.priceChange24H.toStringAsFixed(2).contains('-')
                        ? "- \$" +
                            item.priceChange24H
                                .toStringAsFixed(2)
                                .toString()
                                .replaceAll('-', '')
                        : "\$" + item.priceChange24H.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: widthOne * 0.02),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: item.marketCapChangePercentage24H >= 0
                          ? kgreen
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
