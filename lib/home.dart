import 'package:flutter/material.dart';
import 'package:uncle_sam/cadastro.dart';
import 'package:uncle_sam/login.dart';
import 'package:uncle_sam/sobre.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void onSobrePressed() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SobrePage(title: 'Sobre'))
    );
  }

  void onEntrarPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage(title: 'Entrar'))
    );
  }

  void onCadastrarPressed() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const CadastroPage(title: 'Cadastro'))
    );
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
      backgroundColor: Color.fromARGB(255, 242, 242, 242),
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding (
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 36),
                child: Image(image: AssetImage('assets/images/logo.png'))
            ),
            Padding (
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
              child: SizedBox(
                width: 150.0,
                child: ElevatedButton(
                  onPressed: onSobrePressed,
                  child: const Text('Sobre'),
                ),
              )
            ),
            Padding (
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                child: SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: onEntrarPressed,
                    child: const Text('Entrar'),
                  ),
                )
            ),
            Padding (
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                child: SizedBox(
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: onCadastrarPressed,
                    child: const Text('Cadastrar-me'),
                  ),
                )
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
