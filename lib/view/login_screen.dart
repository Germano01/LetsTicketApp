import 'package:flutter/material.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/view/home_screen.dart';
import 'package:trab/widgets/button.dart';
import 'package:trab/widgets/google_button.dart';
import 'package:trab/widgets/text_field.dart';
import 'package:trab/view/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20.0),
          SizedBox(
            height: 60.0,
            child: Image.asset(
              'assets/img/letsTicketBlueLogo.png',
            ),
          ),
          const SizedBox(height: 32.0),
          CustomTextField(
            label: "Email",
            validator: (value) {},
          ),
          const SizedBox(height: 16.0),
          CustomTextField(
              label: "Senha", isPassword: true, validator: (value) {}),
          const SizedBox(height: 24.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomButton(
              label: "Acessar Conta",
              fontSize: 22.0,
              padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 24.0),
              onPressed: () {
                navigateToScreen(context, const HomeScreen());
              },
            ),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: GoogleButton(
              label: "Continue com o Google",
              onPressed: () {},
            ),
          ),
          const SizedBox(height: 22.0),
          GestureDetector(
            onTap: () {
              navigateToScreen(context, const RegisterScreen());
            },
            child: const Text(
              'Ainda não possui uma conta? Cadastre-se',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
