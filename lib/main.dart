import 'file:///C:/Users/memo_/AndroidStudioProjects/covid_tracker/lib/constant.dart';
import 'package:covidtracker/widgets/counter.dart';
import 'package:covidtracker/widgets/my_header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:modal_progress_hud/modal_progress_hud.dart';

void main() => runApp(MyApp());
var dropdownVal = 'إجمالي الحالات';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid 19',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  var async = false;
  var response;
  @override
  void initState() {
    super.initState();
    fetchPost();
    controller.addListener(onScroll);
  }

  Future<void> fetchPost() async {
    setState(() {
      async = true;
    });

    response = await http.get(
        'https://api.apify.com/v2/actor-tasks/fAYwoNGgat3ujPsgq/runs/last/dataset/items?token=rBjAyWtxMzxmX9C23SgRTFyw4');

    if (response.statusCode == 200) {
      setState(() {
        String body = response.body;
        active = jsonDecode(body)[0]['active'];
        deaths = jsonDecode(body)[0]['deceased'];
        recovered = jsonDecode(body)[0]['recovered'];
        total = jsonDecode(body)[0]['infected'];
        date = jsonDecode(body)[0]['lastUpdatedAtApify'].substring(0, 10);
      });
    } else {
      throw Exception('Failed to load post');
    }
    setState(() {
      async = false;
    });
  }

  void updateResults() {
    setState(() {
      String body = response.body;
      if (dropdownVal == 'إجمالي الحالات') {
        active = jsonDecode(body)[0]['active'];
        deaths = jsonDecode(body)[0]['deceased'];
        recovered = jsonDecode(body)[0]['recovered'];
        total = jsonDecode(body)[0]['infected'];
      } else {
        active = jsonDecode(body)[0][dropdownVal]['active'];
        deaths = jsonDecode(body)[0][dropdownVal]['deceased'];
        recovered = jsonDecode(body)[0][dropdownVal]['recovered'];
        total = jsonDecode(body)[0][dropdownVal]['infected'];
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: async,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: <Widget>[
                MyHeader(
                  sc: true,
                  image: "assets/images/covid19-doc.png",
                  textTop: '',
                  textBottom: "كلنا_مسؤول#",
                  offset: offset,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Case Update\n",
                                  style: kTitleTextstyle,
                                ),
                                TextSpan(
                                  text: "Newest update $date",
                                  style: TextStyle(
                                    color: kTextLightColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              setState(() {
                                async = true;
                              });
                              await http.post(
                                  'https://api.apify.com/v2/actor-tasks/fAYwoNGgat3ujPsgq/run-sync?token=rBjAyWtxMzxmX9C23SgRTFyw4&ui=1');
                              setState(() {
                                async = false;
                              });
                              dropdownVal = 'إجمالي الحالات';
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()));
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 4),
                              blurRadius: 30,
                              color: kShadowColor,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: DropdownButton(
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      icon: Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.blue,
                                      ),
                                      value: dropdownVal,
                                      items: [
                                        'إجمالي الحالات',
                                        'جدة',
                                        'المدينة المنورة',
                                        'مكة المكرمة',
                                        'الرياض',
                                        'الطائف',
                                        'الدمام',
                                        'الخبر',
                                        'الجبيل',
                                        'رابغ',
                                        'ثول',
                                        'تبوك',
                                        'سكاكا',
                                        'عرعر',
                                        'حائل',
                                        'بريدة',
                                        'الباحة',
                                        'أبها',
                                        'خميس مشيط',
                                        'جازان',
                                        'نجران',
                                        'المجمعة',
                                        'ينبع',
                                        'القطيف',
                                        'الظهران',
                                        'حفر الباطن',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownVal = value;
                                          updateResults();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Color(0xFFE5E5E5),
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Counter(
                              color: Colors.red,
                              number: total,
                              title: "TOTAL",
                            ),
                            SizedBox(height: 25),
                            Counter(
                              color: kInfectedColor,
                              number: active,
                              title: "ACTIVE",
                            ),
                            SizedBox(height: 25),
                            Counter(
                              color: kRecovercolor,
                              number: recovered,
                              title: "RECOVERED",
                            ),
                            SizedBox(height: 25),
                            Counter(
                              color: Color(0xFF8B0000),
                              number: deaths,
                              title: "DECEASED",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var active;
var deaths;
var recovered;
var total;
String date;
