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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Jogador O",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        oPont.toString(),
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Jogador X",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        xPont.toString(),
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
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
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 155, 191, 252)),
                      textStyle: MaterialStatePropertyAll(
                          TextStyle(color: Colors.black))),
                  onPressed: () => _limparPontuacao(),
                  child: const Text("Limpar pontuação"),
                ),
              ],
            ),
          )
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
    } else if (filledBoxes == 9) {
      _limpar();
    }
  }

  void _dialogVencedor(String vencedor) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("\"" "$vencedor" "\" é o vencedor!!!"),
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

  void _limpar() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Fim de Jogo"),
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
