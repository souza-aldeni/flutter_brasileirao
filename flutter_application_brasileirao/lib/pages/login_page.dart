import 'package:flutter_application_brasileirao/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  String isLogin = 'login';
  late String titulo;
  late String actionButton;
  late String toggleButton;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    setFormAction(isLogin);
  }

  void setFormAction(String acao) {
    setState(() {
      isLogin = acao;
      if (isLogin == 'login') {
        titulo = 'Bem Vindo';
        actionButton = 'Login';
        toggleButton = 'Ainda não tem conta? Cadastre-se agora';
      } else if (isLogin == 'cadastrar') {
        titulo = 'Crie sua conta';
        actionButton = 'Cadastrar';
        toggleButton = 'Voltar ao Login';
      } else {
        titulo = 'Recupere sua senha';
        actionButton = 'Enviar e-mail';
        toggleButton = 'Voltar ao Login';
      }
    });
  }

  login() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      snackMsg(e.message);
    }
  }

  registrar() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      snackMsg(e.message);
    }
  }

  recuperar() async {
    setState(() {
      loading = true;
    });
    try {
      await context.read<AuthService>().recuperar(email.text);
      snackMsg('E-mail enviado com sucesso');
      setState(() {
        loading = false;
      });
      email.clear();
    } on AuthException catch (e) {
      setState(() {
        loading = false;
      });
      snackMsg(e.message);
    }
  }

  void snackMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.5),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'E-mail',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite um e-mail corretamente';
                            }
                            return null;
                          },
                        )),
                    (isLogin != 'recuperar')
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            child: TextFormField(
                              controller: senha,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Senha',
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value!.length < 6) {
                                  return 'Senha deve ter mais de 6 dígitos';
                                }
                                return null;
                              },
                            ))
                        : const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 1)),
                    Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              if (isLogin == 'login') {
                                login();
                              } else if (isLogin == 'cadastrar') {
                                registrar();
                              } else {
                                recuperar();
                              }
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: (loading)
                                ? [
                                    const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: SizedBox(
                                        width: 24.0,
                                        height: 24.0,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ]
                                : [
                                    const Icon(Icons.check),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        actionButton,
                                        style: const TextStyle(fontSize: 20.0),
                                      ),
                                    )
                                  ],
                          ),
                        )),
                    Column(
                      children: (isLogin == 'login')
                          ? [
                              TextButton(
                                  onPressed: () => setFormAction('recuperar'),
                                  child: const Text('Esqueceu a senha?')),
                              TextButton(
                                  onPressed: () => setFormAction('cadastrar'),
                                  child: Text(toggleButton))
                            ]
                          : [
                              TextButton(
                                  onPressed: () => setFormAction('login'),
                                  child: Text(toggleButton))
                            ],
                    )
                  ],
                ),
              ))),
    );
  }
}
