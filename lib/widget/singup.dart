import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:uncle_sam/main.dart';
import 'package:uncle_sam/utils/utils.dart';

class SingUpWidget extends StatefulWidget {
  final VoidCallback onClickedSingIn;

  const SingUpWidget({super.key, required this.onClickedSingIn});

  @override
  State<SingUpWidget> createState() => _SingUpWidgetState();
}

class _SingUpWidgetState extends State<SingUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding (
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 36),
                child: Image(image: AssetImage('assets/images/logo.png'))
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: 'E-mail'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                email != null && !EmailValidator.validate(email)
                ? 'Digite um e-mail válido'
                : null,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                value != null && value.length < 6
                ? 'Digite no min. 6 caracteres.'
                : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              icon: const Icon(Icons.arrow_forward, size: 32),
              label: const Text (
                'Cadastrar',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: singUp,
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                style: const TextStyle(color: Color.fromARGB(255, 0, 49, 129)),
                text: 'Já é cadastrado? ',
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSingIn,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.secondary
                    ),
                    text: 'Entrar',
                  )
                ]
              )
            )
          ],
        )
      )
    )
  );

  Future singUp() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch(e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
