import 'package:flutter/material.dart';
import 'game_page.dart';

void main() {
  runApp(KrizicKruzic());
}

class KrizicKruzic extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: GamePage()
    );
  }
}
