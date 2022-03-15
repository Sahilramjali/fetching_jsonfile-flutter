import 'dart:convert';

import 'package:fetchapp/countrycode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListJsonData(),
  ));
}

class ListJsonData extends StatefulWidget {
  const ListJsonData({Key? key}) : super(key: key);

  @override
  State<ListJsonData> createState() => _ListJsonDataState();
}

class _ListJsonDataState extends State<ListJsonData> {
  List<dynamic>? dataRetrieved;
  Future<List<Country>> ReadJsonData() async {
    final jsondata = await rootBundle.loadString('assets/CountryCodes.json');
    final list = json.decode(jsondata) as List<dynamic>;
    return list.map((e) => Country.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("list country code"),
        ),
        body: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasData) {
              var item = data.data as List<Country>;
              return ListView.builder(
                itemCount: item.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 5, 0),
                                        child: Center(
                                          child: Text("country name : " +
                                              item[index].name.toString()),
                                        ),
                                      ),
                                      Text("dial code : " +
                                          item[index].dial_code.toString()),
                                      Text("code : " +
                                          item[index].code.toString()),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
