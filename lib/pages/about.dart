import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Sobre a barbearia'),
    ),
    body: Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/about.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomLeft,
          ),
        ),
        Padding (
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Uncle Sam",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fundada em 15 de julho de 2013 por João Torres, a barbearia executiva Uncle Sam’s atua na principal regiões de Belo Horizonte Savassi. O conceito da barbearia é referência em estética masculina em Belo Horizonte, consolidando-se, inclusive, como preferência de diversos jogadores de futebol, além de outros boleiros do país que não abrem mão de um bom corte de cabelo e uma barba bem feita.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ],
          ),
        ),
      ],
    )
  );

}
