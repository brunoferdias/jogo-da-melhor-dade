import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jogo_da_melhor_idade/my_game_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:validadores/Validador.dart';

class Names extends StatefulWidget {
  const Names({Key? key}) : super(key: key);

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {

  late TextEditingController _playerA = TextEditingController();
  late TextEditingController _playerB = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String nomeA = '';
  String nomeB = '';

  get namePlayer1 => _playerA.text;
  get namePlayer2 => _playerB.text;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        } //Esconde o teclado ao clicar em outro lugar!!!!!!!!!!!!!!!!
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
          elevation: 20,
          title: Text('Jogo da Melhor Idade👵',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 24,fontWeight: FontWeight.w200),),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue, Colors.green],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: TextFormField(

                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                         textInputAction: TextInputAction.next,
                          controller: _playerA,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          validator: (value) {
                            if (_playerA.text == null || _playerA.text.isEmpty) {
                              return 'Por favor, insira o nome';
                            }
                            return null;
                          },
                          /*onSaved: (value) {
                            _playerA.text = value! as String;
                          },*/
                          style: TextStyle(
                              color: Colors.blue.shade900, //
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          ),

                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.fade
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color:  Colors.blue.shade900,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color:  Colors.blue.shade900,
                                )),
                            //hoverColor: Colors.greendf,
                            filled: true,
                            fillColor: Colors.white,
                            helperStyle: TextStyle(
                              color: Colors.white, // define a cor do helper text
                            ),
                            hintText: "Nome Jogador X",
                            hintStyle: TextStyle(
                              color: Colors.blue.shade900, //
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 15),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 300),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          controller: _playerB,
                          textAlign: TextAlign.center,
                          maxLength: 10,
                          validator: (value) {
                            if (_playerB.text.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            if (_playerB.text == namePlayer1) {
                              return 'Nomes iguais!';
                            }
                            return null;
                          },
                          style: TextStyle(
                              color: Colors.blue.shade900, //
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                          ),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color:  Colors.blue.shade900,
                                )),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  color:  Colors.blue.shade900,
                                )),
                            //hoverColor: Colors.greendf,
                            filled: true,
                            errorStyle: TextStyle(
                              color: Colors.red.shade900,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                                overflow: TextOverflow.visible
                            ),
                            fillColor: Colors.white,
                            helperStyle: TextStyle(
                              color: Colors.white, // define a cor do helper text
                            ),
                            hintText: "Nome Jogador O",
                            hintStyle: TextStyle(
                                color: Colors.blue.shade900, //
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

                    Container(
                      width: 210,
                      child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.heavyImpact();



                          if (formKey.currentState!.validate()) {

                            setState(() {
                              nomeA = _playerA.text;
                              nomeB = _playerB.text;
                            });

                            print('nome a = $nomeA}\nnome b = $nomeB');

                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                alignment: Alignment.center,
                                child: MyGame(nomeA: nomeA,nomeB: nomeB,),
                                isIos: true,
                                duration: Duration(milliseconds: 850),
                                reverseDuration: Duration(milliseconds: 850),
                              ),
                            );

                          }



                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Começar",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          //backgroundColor: Color.fromARGB(255, 255, 57, 0),
                          backgroundColor: Colors.blue.shade900,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
