import 'package:flutter/material.dart';


class SobrePage extends StatefulWidget {
  const SobrePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SobrePage> createState() => _SobrePageState();
}

class _SobrePageState extends State<SobrePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Fundada em 15 de julho de 2013 por João Torres, a barbearia executiva Uncle Sam’s atua na principal regiões de Belo Horizonte Savassi. O conceito da barbearia é referência em estética masculina em Belo Horizonte, consolidando-se, inclusive, como preferência de diversos jogadores de futebol do Atlético Mineiro e do Cruzeiro, além de outros boleiros do país que não abrem mão de um bom corte de cabelo e uma barba bem feita.',
            ),
          ],
        ),
      ),
    );
  }
}
