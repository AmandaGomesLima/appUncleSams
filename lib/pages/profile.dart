import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  String _name = FirebaseAuth.instance.currentUser!.displayName!;
  final nameController = TextEditingController();

  _ProfilePageState() {
    nameController.text = _name;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Perfil'),
    ),
    body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text (
              'Logado  como',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              _name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_back, size: 32),
              label: const Text (
                'Sair',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
            const SizedBox(height: 40),
            const Divider(
                color: Colors.grey
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Meu nome'),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.edit, size: 32),
              label: const Text (
                'Atualizar',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: updateUser,
            ),
          ]
        )
      )
    )
  );

  void updateUser() {
    if (nameController.text.isNotEmpty) {
      user.updateDisplayName(nameController.text);
      setState(() {
        _name = nameController.text;
      });
      log("Atualizado com sucesso");
    }
    else {
      log("Por favor, preencha todos os campos.");
    }
  }
}
