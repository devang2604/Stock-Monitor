import 'package:crypto_api/constants.dart';
import 'package:crypto_api/models/coin_model.dart';
import 'package:crypto_api/pages/components/item.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCoinMarket();
  }

  @override
  Widget build(BuildContext context) {
    double heightOne = MediaQuery.of(context).size.height;
    double widthOne = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: heightOne,
        width: widthOne,
        decoration: const BoxDecoration(
          color: kblack,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: heightOne * 0.023),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: widthOne * 0.01,
                        vertical: heightOne * 0.005),
                    decoration: BoxDecoration(
                      color: kdarkgrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Main Portfolio",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Text(
                    "Top 10",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "Experimental",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthOne * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 3,879.09',
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(widthOne * 0.02),
                    height: heightOne * 0.04,
                    width: widthOne * 0.1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kdarkgrey.withOpacity(0.5),
                    ),
                    child: Image.asset(
                      "assets/icons/grow.png",
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widthOne * 0.07),
              child: Row(
                children: [
                  Text(
                    "+ 201% all time",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: heightOne * 0.02,
            ),
            Container(
              height: heightOne * 0.7,
              width: widthOne,
              decoration: const BoxDecoration(
                color: kdarkgrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: heightOne * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthOne * 0.08),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Assets",
                          style: TextStyle(fontSize: 14),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  Expanded(
                    child: isRefreshing == true
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: 4,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Item(
                                item: coinMarket![index],
                              );
                            },
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthOne * 0.08),
                    child: Row(
                      children: [
                        Text(
                          "Recommend to buy",
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: heightOne * 0.02,
                  ),
                  Expanded(
                    child: Container(
                      // height: heightOne * 0.23,
                      width: widthOne,
                      color: kgreen,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';
    setState(() {
      isRefreshing = false;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }
  }
}
