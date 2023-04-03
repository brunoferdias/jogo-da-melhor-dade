import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  const MyGame({Key? key}) : super(key: key);

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  List grade = [

 //  0   1   2             <= Linha
    ['', '', ''], // 0
    ['', '', ''], // 1
    ['', '', ''], // 2
  ];
            //   Coluna

  placarContagem() {
    if (textoInformativo == "Bruno Venceu!") {
      placarA++;
    } else if (textoInformativo == "Lucas Venceu!") {
      placarB++;
    } else {
      print("empate");
    }
  }

  String jogadorAtual = 'X';
  String nomeJogador = 'Bruno';
  int placarA = 0;
  int placarB = 0;
  String textoInformativo = 'Vamos Começar?';
  bool jogoIniciado = false;
  int jogadas = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Placar
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "B  |  L",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$placarA  |  $placarB",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      placarB = 0;
                      placarA = 0;
                    });
                  },
                  child: Text(
                    'zerar',
                    style: TextStyle(fontSize: 23),
                  ))
            ],
          ),

          AbsorbPointer(
            absorbing: !jogoIniciado,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Jogo da Velha",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.black,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(linha: 0, coluna: 0),
                    myButton(linha: 0, coluna: 1),
                    myButton(linha: 0, coluna: 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(linha: 1, coluna: 0),
                    myButton(linha: 1, coluna: 1),
                    myButton(linha: 1, coluna: 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    myButton(linha: 2, coluna: 0),
                    myButton(linha: 2, coluna: 1),
                    myButton(linha: 2, coluna: 2),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  textoInformativo,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              AbsorbPointer(
                  absorbing: jogoIniciado,
                  child: Opacity(
                      opacity: jogoIniciado ? 0 : 1, child: btInicio())),
            ],
          )
        ],
      ),
    );
  }

  Widget myButton({required int linha, required int coluna}) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: AbsorbPointer(
        absorbing: grade[linha][coluna] == '' ? false : true,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              clique(linha: linha, coluna: coluna);
            });
          },
          style: ElevatedButton.styleFrom(
              fixedSize: Size(100, 100), primary: Colors.black38),
          child: Text(
            grade[linha][coluna],
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),
    );
  }

  Widget btInicio() {
    return Padding(
      padding: EdgeInsets.all(4),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            jogoIniciado = true;
            jogadas = 0;
            grade = List.generate(3, (i) => List.filled(3, ''));
            textoInformativo = '$nomeJogador é sua vez!';
          });
        },
        style: ElevatedButton.styleFrom(
            fixedSize: Size(200, 50), primary: Colors.amber),
        child: Text(
          jogadas > 0 ? "Jogar novamente" : 'Bora Jogar!',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }

  bool verificaVencedor(
      {required String jogador, required int linha, required int coluna}) {
    bool venceu = true;

    // verifica linha
    for (int i = 0; i < 3; i++) {
      if (grade[linha][i] != jogador) {
        venceu = false;
        break;
      }else{
        venceu = true;
      }
    }

    // verifica coluna
    if (venceu == false) {
      for (int j = 0; j < 3; j++) {
        if (grade[j][coluna] != jogador) {
          venceu = false;
          break;
        } else {
          venceu = true;
        }
        //print("Parou na coluna reta");
      }
    }

    //verifica diagonal
    if (venceu == false) {
      if (grade[1][1] == jogador) {
        print('Clicou no bt meio');
        if (grade[0][0] == jogador && grade[2][2] == jogador) {
          print("Parou na diagonal");
          venceu = true;
        } else if (grade[0][2] == jogador && grade[2][0] == jogador) {
          print("Parou na diagonal");
          venceu = true;
        }
      }
    }

    return venceu;
  }

  // logica do clique
  void clique({required int linha, required int coluna}) {
    jogadas++;
    grade[linha][coluna] = jogadorAtual;
    bool existeVencedor =
        verificaVencedor(jogador: jogadorAtual, linha: linha, coluna: coluna);
    if (existeVencedor) {
      textoInformativo = '$nomeJogador Venceu!';
      jogoIniciado = false;
      placarContagem();
    } else if (existeVencedor == false && jogadas == 9) {
      textoInformativo = 'Empate!';
      jogoIniciado = false;
    } else {
      if (jogadorAtual == 'X') {
        jogadorAtual = 'O';
        nomeJogador = 'Lucas';
      } else {
        jogadorAtual = 'X';
        nomeJogador = 'Bruno';
      }
      textoInformativo = '$nomeJogador é sua vez.';
    }
  }
}
