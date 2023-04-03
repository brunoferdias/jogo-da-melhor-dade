import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'nomes_page.dart';

class MyGame extends StatefulWidget {
  const MyGame({
    Key? key,
    required this.nomeA,
    required this.nomeB,
  }) : super(key: key);

  final String nomeA;
  final String nomeB;


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
    if (textoInformativo == "${widget.nomeA} Venceu!") {
      placarA++;
    } else if (textoInformativo == "${widget.nomeB} Venceu!") {
      placarB++;
    } else {
      print("empate");
    }
  }

  String jogadorAtual = 'X';
  String nomeJogador = '';
  int placarA = 0;
  int placarB = 0;
  String textoInformativo = 'Vamos Começar?';
  bool jogoIniciado = false;
  int jogadas = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nomeJogador = widget.nomeA;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    print(screenSize.toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        centerTitle: true,
        elevation: 20,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                alignment: Alignment.center,
                child: Names(),
                isIos: true,
                duration: Duration(milliseconds: 850),
                reverseDuration: Duration(milliseconds: 850),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 25,
          ),
        ),
        title: Text(
          'Jogo da Melhor Idade👵',
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 24,
              fontWeight: FontWeight.w200),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.nomeA,style: TextStyle(fontSize: 33,fontWeight: FontWeight.w200,overflow: TextOverflow.ellipsis),),
                          Text(placarA.toString(),style: TextStyle(fontSize: 33,fontWeight: FontWeight.w200),),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.49,
                    ),
                    Container(height: double.infinity,color: Colors.black,width: 0.2,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.49,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(widget.nomeB,style: TextStyle(fontSize: 33,fontWeight: FontWeight.w200,overflow: TextOverflow.ellipsis),),
                          Text(placarB.toString(),style: TextStyle(fontSize: 33,fontWeight: FontWeight.w200),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              AbsorbPointer(
                absorbing: placarA != 0 || placarB != 0 ? false : true,
                child: Opacity(
                  opacity: placarA != 0 || placarB != 0 ? 1 : 0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          placarB = 0;
                          placarA = 0;
                        });
                      },
                      child: Text(
                        'Zerar placar',
                        style: TextStyle(fontSize: 20),
                      )),
                ),
              ),

              screenSize.height > 700 ? SizedBox(height: 50,) : SizedBox(height: 0),

              AbsorbPointer(
                absorbing: !jogoIniciado,
                child: Column(
                  children: [

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
                          fontSize: 25,
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
        ),
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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              fixedSize: Size(100, 100),
              primary: Colors.black38),
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
        style: ElevatedButton.styleFrom(
          elevation: 24,
          fixedSize: Size(200, 50),
          backgroundColor: Colors.blue.shade400,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          setState(() {
            jogoIniciado = true;
            jogadas = 0;
            grade = List.generate(3, (i) => List.filled(3, ''));
            textoInformativo = '$nomeJogador é sua vez!';
          });
        },
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
      } else {
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

      }
    }

    //verifica diagonal
    if (venceu == false) {
      if (grade[1][1] == jogador) {

        if (grade[0][0] == jogador && grade[2][2] == jogador) {

          venceu = true;
        } else if (grade[0][2] == jogador && grade[2][0] == jogador) {

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
        nomeJogador = widget.nomeB;
      } else {
        jogadorAtual = 'X';
        nomeJogador = widget.nomeA;
      }
      textoInformativo = '$nomeJogador é sua vez.';
    }
  }
}
