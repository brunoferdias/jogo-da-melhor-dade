import 'package:flutter/material.dart';
import 'package:jogo_da_melhor_idade/nomes_page.dart';

import 'my_game_page.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Names(),
    );
  }
}
