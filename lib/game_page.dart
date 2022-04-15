import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GamePage extends StatefulWidget {

  @override
  State<GamePage> createState() => _GamePageState();
}


class _GamePageState extends State<GamePage> {

  Color negativeColor = Color(0xFF0A0E21);
  Color krizicColor = Colors.pinkAccent;
  Color kruzicColor = Colors.purple;

  List<List<int>> polje = [
    [0,0,0],
    [0,0,0],
    [0,0,0]
  ];

  int red = 0;
  int stup = 0;
  int gotovo = 0;

  bool x = true;  //true je za krizice a false za kruzice

  void check(bool x){
    int i, j;
    bool pobjeda = false;
    bool xpob = false;
    for(i=0; i<3; i++){
      if (polje[i][0] != 0 && polje[i][0] == polje[i][1] && polje[i][0] == polje[i][2]){
        pobjeda = true;
        if (polje[i][0]==1) xpob = true;
          setState(() {
            polje[i][0] = 3;
            polje[i][1] = 3;
            polje[i][2] = 3;
          });
      };
      if (polje[0][i] != 0 && polje[0][i] == polje[1][i] && polje[0][i] == polje[2][i]){
        pobjeda = true;
        if (polje[0][i]==1) xpob = true;
          setState(() {
            polje[0][i] = 3;
            polje[1][i] = 3;
            polje[2][i] = 3;
          });
      }
    }
    if (polje[0][0] != 0 && polje[1][1] == polje[0][0] && polje[0][0] == polje[2][2]){
      pobjeda = true;
      if (polje[0][0]==1) xpob = true;
        setState(() {
          polje[0][0] = 3;
          polje[1][1] = 3;
          polje[2][2] = 3;
        });
    }
    if (polje[0][2] != 0 && polje[0][2] == polje[1][1] && polje[0][2] == polje[2][0]){
      pobjeda = true;
      if (polje[2][0]==1) xpob = true;
      Future.delayed(Duration(milliseconds: 50), (){
        setState(() {
          polje[0][2] = 3;
          polje[1][1] = 3;
          polje[2][2] = 3;
        });
      });
    }
    if (pobjeda == true){
        Timer(Duration(milliseconds: 50), () { // <-- Delay here
          if(xpob) {
            Alert(
                context: context,
                title: "POBJEDNIK:",
                content: Icon(
                  Icons.close,
                  color: krizicColor,
                  size: 50.0,
                ),
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "IGRAJ PONOVNO",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }
          else{
            Alert(
                context: context,
                title: "POBJEDNIK:",
                content: Icon(
                  Icons.circle_outlined,
                  color: kruzicColor,
                  size: 50.0,
                ),
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "IGRAJ PONOVNO",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }
          setState(() {
            gotovo = 0;
            polje = [
              [0,0,0],
              [0,0,0],
              [0,0,0]
            ];
          });
        });

    }
    else {
      if (gotovo==9) {
        Alert(
            context: context,
            title: "NERIJEŠENO!",
            buttons: [
              DialogButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "IGRAJ PONOVNO",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ]).show();
        setState(() {
          gotovo = 0;
          polje = [
            [0, 0, 0],
            [0, 0, 0],
            [0, 0, 0]
          ];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("Križić - kružić")),
      ),
      body:
        Column(
          children: [
            Container(
                color: Color(0xFF0A0E21),
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.centerLeft,
                height: 40.0,
                width: double.infinity,
                child: Icon(
                  x ? Icons.close : Icons.circle_outlined,
                  color: x ? krizicColor : kruzicColor,
                ),
              ),
            Redic(0),
            SizedBox(
              height: 5.0,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white
                  ),
              ),
            ),
            Redic(1),
            SizedBox(
              height: 5.0,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
              ),
            ),
            Redic(2),
          ],
        )
    );
  }

  Expanded Redic(int stup) {
    return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cell(negativeColor, 0, stup),
                SizedBox(
                  width: 5.0,
                  height: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                  ),
                ),
                cell(negativeColor, 1, stup),
                SizedBox(
                  width: 5.0,
                  height: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white
                      ),
                    ),
                ),
                cell(krizicColor, 2, stup)
              ],

            ),
          );
  }

  Expanded cell(Color c, int red, int stup) {
    return Expanded(
      child: Container(
                  color: polje[red][stup] == 0 ? Color(0xFF0A0E21) : polje[red][stup]==1 ? krizicColor : polje[red][stup]==2 ? kruzicColor : Colors.green,
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        gotovo++;
                        if(polje[red][stup] == 0){
                          polje[red][stup] = x ? 1 : 2;
                        }
                        if (x == true){
                          x = false;
                        }
                        else{
                          x = true;
                        }
                      });
                      check(x);
                    },
                    child: Icon(
                        polje[red][stup] == 0 ? Icons.circle : polje[red][stup]==1 ? Icons.close
                            : polje[red][stup]==2 ? Icons.circle_outlined
                            : polje[red][stup]==3 ? x ? Icons.circle_outlined : Icons.close : Icons.close,
                        color: polje[red][stup] == 0 ? Color(0xFF0A0E21) : Colors.white,
                        size: 100.0,
                    ),
                  ),
      ),
    );
  }
}
