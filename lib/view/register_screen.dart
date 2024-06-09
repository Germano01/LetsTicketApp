import 'package:flutter/material.dart';
import 'package:trab/utils/utils.dart';
import 'package:trab/view/home_screen.dart';
import 'package:trab/widgets/button.dart';
import 'package:trab/widgets/google_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isPasswordVisible = false;
  bool _termsChecked = false;
  bool _isMale = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Senha',
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
      obscureText: !_isPasswordVisible,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor insira uma senha';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                  child: Image.asset(
                    'assets/img/letsTicketBlueLogo.png',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o nome completo';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira um email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'WhatsApp'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o número do WhatsApp';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                _buildPasswordTextField(),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'CPF'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira o CPF';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Container(
                      width: 165,
                      margin: const EdgeInsets.only(right: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Masculino'),
                        leading: Radio<bool>(
                          value: true,
                          groupValue: _isMale,
                          onChanged: (bool? value) {
                            setState(() {
                              _isMale = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 165,
                      margin: const EdgeInsets.only(right: 8.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Feminino'),
                        leading: Radio<bool>(
                          value: false,
                          groupValue: _isMale,
                          onChanged: (bool? value) {
                            setState(() {
                              _isMale = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _termsChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _termsChecked = value!;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _termsChecked = !_termsChecked;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Aceito os termos e condições',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Já possui uma conta? Faça login',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CustomButton(
                    label: "Criar Conta",
                    fontSize: 22.0,
                    padding: const EdgeInsets.fromLTRB(32.0, 24.0, 32.0, 24.0),
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _termsChecked) {
                        navigateToScreen(context, HomeScreen());
                      } else {
                        if (!_termsChecked) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Você precisa aceitar os termos e condições para continuar.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
