import 'package:flutter/material.dart';
import 'package:uncle_sam/cadastro.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  void onPressed() {
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
            Image(image: AssetImage('assets/images/logo.png')),
            Padding (
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              child: TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              )
            ),
            Padding (
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 6),
                child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Senha',
                  ),
                )
            ),
            ElevatedButton(onPressed: onPressed, child: const Text('Entrar'))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
