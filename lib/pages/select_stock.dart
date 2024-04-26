import 'dart:convert';
import 'package:crypto_api/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:crypto_api/models/chart_model.dart';

class SelectCoin extends StatefulWidget {
  var selectItem;

  SelectCoin({this.selectItem});
  @override
  State<SelectCoin> createState() => _SelectCoinState();
}

class _SelectCoinState extends State<SelectCoin> {
  late TrackballBehavior trackballBehavior;
  String newsTitle = "";
  String newsDescription = "";
  bool _isTapped = false;

  @override
  void initState() {
    getChart();
    getNews();
    trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: SizedBox(
          height: myHeight,
          width: myWidth,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: myWidth * 0.05,
                  right: myWidth * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: myHeight * 0.05,
                          child: Image.network(widget.selectItem.image),
                        ),
                        SizedBox(
                          width: myWidth * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectItem.id,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: myHeight * 0.01,
                            ),
                            Text(
                              widget.selectItem.symbol,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${widget.selectItem.currentPrice}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(
                          height: myHeight * 0.01,
                        ),
                        Text(
                          '${widget.selectItem.marketCapChangePercentage24H}%',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: widget.selectItem
                                          .marketCapChangePercentage24H >=
                                      0
                                  ? Colors.green
                                  : Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: myWidth * 0.05,
                          vertical: myHeight * 0.005),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Low',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: myHeight * 0.01,
                              ),
                              Text(
                                '\$${widget.selectItem.low24H}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'High',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: myHeight * 0.01,
                              ),
                              Text(
                                '\$${widget.selectItem.high24H}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Vol',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: myHeight * 0.01,
                              ),
                              Text(
                                '\$${(widget.selectItem.totalVolume / 1000000).toStringAsFixed(2)}M',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.015,
                    ),
                    SizedBox(
                      height: myHeight * 0.3,
                      width: myWidth,
                      // color: Colors.amber,
                      child: isRefresh == true
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: kgreen,
                              ),
                            )
                          : itemChart == null
                              ? Padding(
                                  padding: EdgeInsets.all(myHeight * 0.06),
                                  child: const Center(
                                    child: Text(
                                      'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              : SfCartesianChart(
                                  trackballBehavior: trackballBehavior,
                                  zoomPanBehavior: ZoomPanBehavior(
                                      enablePinching: true,
                                      zoomMode: ZoomMode.x),
                                  series: <CandleSeries>[
                                    CandleSeries<ChartModel, int>(
                                      enableSolidCandles: true,
                                      enableTooltip: true,
                                      bullColor: Colors.green,
                                      bearColor: Colors.red,
                                      dataSource: itemChart!,
                                      xValueMapper: (ChartModel sales, _) =>
                                          sales.time,
                                      lowValueMapper: (ChartModel sales, _) =>
                                          sales.low,
                                      highValueMapper: (ChartModel sales, _) =>
                                          sales.high,
                                      openValueMapper: (ChartModel sales, _) =>
                                          sales.open,
                                      closeValueMapper: (ChartModel sales, _) =>
                                          sales.close,
                                      animationDuration: 55,
                                    )
                                  ],
                                ),
                    ),
                    SizedBox(
                      height: myHeight * 0.01,
                    ),
                    Center(
                      child: SizedBox(
                        height: myHeight * 0.04,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: text.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: myWidth * 0.02),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textBool = [
                                      false,
                                      false,
                                      false,
                                      false,
                                      false,
                                      false
                                    ];
                                    textBool[index] = true;
                                  });
                                  setDays(text[index]);
                                  getChart();
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: myWidth * 0.03,
                                      vertical: myHeight * 0.005),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: textBool[index] == true
                                        ? kgreen.withOpacity(0.5)
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    text[index],
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: myHeight * 0.02,
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: myWidth * 0.06,
                              vertical: myHeight * 0.01,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        newsTitle.isEmpty
                                            ? "Loading news..."
                                            : newsTitle,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: myHeight * 0.01,
                                      ),
                                      Text(
                                        newsDescription.isEmpty
                                            ? ""
                                            : newsDescription,
                                        textAlign: TextAlign.justify,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: myWidth * 0.25,
                                  child: CircleAvatar(
                                    radius: myHeight * 0.04,
                                    backgroundImage:
                                        const AssetImage('assets/11.PNG'),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: myHeight * 0.1,
                width: myWidth,
                child: Column(
                  children: [
                    const Divider(),
                    // SizedBox(
                    //   height: myHeight * 0.005,
                    // ),
                    Row(
                      children: [
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: myHeight * 0.015),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: kgreen),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  size: myHeight * 0.02,
                                ),
                                const Text(
                                  'Add to portfolio',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isTapped = !_isTapped;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: myHeight * 0.012),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: _isTapped
                                    ? Colors.amber
                                    : Colors.grey.withOpacity(0.2),
                              ),
                              child: Icon(
                                _isTapped
                                    ? Icons.notifications_active
                                    : Icons.notifications_none,
                                color: _isTapped ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: myWidth * 0.05,
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: myHeight * 0.005,
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> text = ['D', 'W', 'M', '3M', '6M', 'Y'];
  List<bool> textBool = [false, false, true, false, false, false];

  int days = 30;

  setDays(String txt) {
    if (txt == 'D') {
      setState(() {
        days = 1;
      });
    } else if (txt == 'W') {
      setState(() {
        days = 7;
      });
    } else if (txt == 'M') {
      setState(() {
        days = 30;
      });
    } else if (txt == '3M') {
      setState(() {
        days = 90;
      });
    } else if (txt == '6M') {
      setState(() {
        days = 180;
      });
    } else if (txt == 'Y') {
      setState(() {
        days = 365;
      });
    }
  }

  List<ChartModel>? itemChart;

  bool isRefresh = true;

  Future<void> getChart() async {
    String url = 'https://api.coingecko.com/api/v3/coins/' +
        widget.selectItem.id +
        '/ohlc?vs_currency=usd&days=' +
        days.toString();

    setState(() {
      isRefresh = true;
    });

    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });

    setState(() {
      isRefresh = false;
    });
    if (response.statusCode == 200) {
      Iterable x = json.decode(response.body);
      List<ChartModel> modelList =
          x.map((e) => ChartModel.fromJson(e)).toList();
      setState(() {
        itemChart = modelList;
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<void> getNews() async {
    String newsApiKey = "64eeb7be475f48058a1377b08827b879";
    String coinName = widget.selectItem.id;
    String newsUrl =
        "https://newsapi.org/v2/everything?q=$coinName&apiKey=$newsApiKey";

    var newsResponse = await http.get(Uri.parse(newsUrl));

    if (newsResponse.statusCode == 200) {
      var newsData = json.decode(newsResponse.body);

      if (newsData["articles"].isNotEmpty) {
        String firstArticleTitle = newsData["articles"][0]["title"];
        String firstArticleDescription =
            newsData["articles"][0]["description"] ?? "";
        setState(() {
          newsTitle = firstArticleTitle;
          newsDescription = firstArticleDescription;
        });
      } else {
        setState(() {
          newsTitle = "No news found for ${coinName}.";
          newsDescription = "";
        });
      }
    } else {
      print(newsResponse.statusCode);
      setState(() {
        newsTitle = "Error fetching news.";
        newsDescription = "";
      });
    }
  }
}
