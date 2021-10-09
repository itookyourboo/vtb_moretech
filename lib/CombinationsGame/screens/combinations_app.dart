import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CombinationsApp extends StatefulWidget {
  const CombinationsApp({Key? key}) : super(key: key);

  @override
  State<CombinationsApp> createState() => _CombinationsAppState();
}

class _CombinationsAppState extends State<CombinationsApp> {
  var list = ["T", "E", "S", "T"];
  var list_new = [-1, -1, -1, -1];
  var word_now = ["", "", "", ""];
  var white_list = ["ES", "EST", "TT"];
  var black_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ETO WHO"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: 20.0),
          // height: 50.0,
          child: Column(
            children: [
              Row(
                  children: List.generate(list.length, (index) {
                return Container(
                  width: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (list[index] != "") {
                          list_new[index] = index;
                          for (var i = 0; i < word_now.length; i++) {
                            if (word_now[i] == "") {
                              word_now[i] = list[index];
                              list[index] = "";
                              break;
                            }
                          }
                        }
                      });
                    },
                    child: Text(list[index]),
                  ),
                );
              })),
              Row(
                  children: List.generate(list_new.length, (index) {
                return Container(
                  width: 50.0,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if (word_now[index] != "") {
                          list[list_new[index]] = word_now[index];
                          list_new[index] = -1;
                          for (var i = index; i < word_now.length; i++) {
                              if (i < word_now.length - 1) {
                                word_now[i] = word_now[i + 1];
                                list_new[i] = list_new[i + 1];
                              }
                          }

                        }
                      });
                    },
                    child: Text(word_now[index]),
                  ),
                );
              })),
            ],
          ),
        ));
  }
}
