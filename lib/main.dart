import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String letra = 'X';

  // declarations
  bool oJogada = true;

  // 1st player is O
  List<String> listGrade = ['', '', '', '', '', '', '', '', ''];
  int oPont = 0;
  int xPont = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                int linha = index ~/ 3;
                int coluna = index % 3;
                return GestureDetector(
                  onTap: () => _clicado(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        listGrade[index],
                        style:
                            const TextStyle(color: Colors.black, fontSize: 35),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Container(
          //   color: Colors.amber,
          //   height: 150,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Flexible(
          //         child: GestureDetector(
          //           child: Container(
          //             width: double.infinity,
          //             color: Colors.yellow,
          //             child: Center(child: Text(letra)),
          //           ),
          //           onTap: () {
          //             if (letra == 'N') {
          //               setState(() {
          //                 letra = 'O';
          //               });
          //             }
          //             print(1);
          //           },
          //         ),
          //       ),
          //       Flexible(
          //         child: GestureDetector(
          //           child: Container(
          //             width: double.infinity,
          //             color: Colors.blue,
          //           ),
          //           onTap: () {
          //             print(2);
          //           },
          //         ),
          //       ),
          //       Flexible(
          //         child: GestureDetector(
          //           child: Container(
          //             width: double.infinity,
          //             color: Colors.red,
          //           ),
          //           onTap: () {
          //             print(3);
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  void _clicado(int index) {
    setState(() {
      if (oJogada && listGrade[index] == '') {
        listGrade[index] = 'O';
        filledBoxes++;
      } else if (!oJogada && listGrade[index] == '') {
        listGrade[index] = 'X';
        filledBoxes++;
      }

      oJogada = !oJogada;
      _checarVencedor();
    });
  }

  void _checarVencedor() {
    // Posição
    // 0   1   2
    // 3   4   5
    // 6   7   8

    // Variaveis iguais em linha
    if (listGrade[0] == listGrade[1] &&
        listGrade[0] == listGrade[2] &&
        listGrade[0] != '') {
      _dialogVencedor(listGrade[0]);
    }
    if (listGrade[3] == listGrade[4] &&
        listGrade[3] == listGrade[5] &&
        listGrade[3] != '') {
      _dialogVencedor(listGrade[3]);
    }
    if (listGrade[6] == listGrade[7] &&
        listGrade[6] == listGrade[8] &&
        listGrade[6] != '') {
      _dialogVencedor(listGrade[6]);
    }

    //Variaveis iguais colunas
    if (listGrade[0] == listGrade[3] &&
        listGrade[0] == listGrade[6] &&
        listGrade[0] != '') {
      _dialogVencedor(listGrade[0]);
    }
    if (listGrade[1] == listGrade[4] &&
        listGrade[1] == listGrade[7] &&
        listGrade[1] != '') {
      _dialogVencedor(listGrade[1]);
    }
    if (listGrade[2] == listGrade[5] &&
        listGrade[2] == listGrade[8] &&
        listGrade[2] != '') {
      _dialogVencedor(listGrade[2]);
    }

    // Variáveis iguais diagonal
    if (listGrade[0] == listGrade[4] &&
        listGrade[0] == listGrade[8] &&
        listGrade[0] != '') {
      _dialogVencedor(listGrade[0]);
    }
    if (listGrade[2] == listGrade[4] &&
        listGrade[2] == listGrade[6] &&
        listGrade[2] != '') {
      _dialogVencedor(listGrade[2]);
    }
  }

  void _dialogVencedor(String vencedor) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("\"" + vencedor + "\" É O VENCEDOR!!!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _limparGrid();
                Navigator.of(context).pop();
              },
              child: const Text('Jogar novamente'),
            )
          ],
        );
      },
    );
    if (vencedor == 'O') {
      oPont++;
    } else {
      xPont++;
    }
  }

  void _limpar(String vencedor) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Limpar"),
          actions: [
            ElevatedButton(
              onPressed: () {
                _limparGrid();
                Navigator.of(context).pop();
              },
              child: const Text('Jogar novamente'),
            )
          ],
        );
      },
    );
    if (vencedor == 'O') {
      oPont++;
    } else {
      xPont++;
    }
  }

  void _limparGrid() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        listGrade[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void _limparPontuacao() {
    setState(() {
      oPont = 0;
      xPont = 0;
      for (var i = 0; i < 9; i++) {
        listGrade[i] = '';
      }
      filledBoxes = 0;
    });
  }
}
