// ABRACADABRAKIDS - COM LOGIN FAKE + APP COMPLETO

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AbracadabraKids',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const LoginPage(),
    );
  }
}

// ================= LOGIN FAKE =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void login() {
    if (userController.text.isNotEmpty && passController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha usuário e senha')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.child_care, size: 80, color: Colors.purple),
              const SizedBox(height: 20),
              const Text(
                'AbracadabraKids',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: userController,
                decoration: const InputDecoration(labelText: 'Usuário'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Senha'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: login,
                child: const Text('Entrar'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ================= APP PRINCIPAL =================

class Atividade {
  String nome;
  bool concluida;

  Atividade(this.nome, {this.concluida = false});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Atividade> atividades = [];
  final TextEditingController controller = TextEditingController();

  void adicionarAtividade() {
    if (controller.text.isNotEmpty) {
      setState(() {
        atividades.add(Atividade(controller.text));
        controller.clear();
      });
    }
  }

  void removerAtividade(int index) {
    setState(() {
      atividades.removeAt(index);
    });
  }

  void alternarConclusao(int index) {
    setState(() {
      atividades[index].concluida = !atividades[index].concluida;
    });
  }

  void limparTudo() {
    setState(() {
      atividades.clear();
    });
  }

  int totalConcluidas() {
    return atividades.where((a) => a.concluida).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('AbracadabraKids 🎈'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: limparTudo,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Gerenciar Atividades',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'Concluídas: ${totalConcluidas()} / ${atividades.length}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Nova atividade...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: adicionarAtividade,
                  child: const Icon(Icons.add),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: atividades.isEmpty
                  ? const Center(child: Text('Nenhuma atividade 😢'))
                  : ListView.builder(
                      itemCount: atividades.length,
                      itemBuilder: (context, index) {
                        final atividade = atividades[index];

                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: atividade.concluida,
                              onChanged: (_) => alternarConclusao(index),
                            ),
                            title: Text(
                              atividade.nome,
                              style: TextStyle(
                                decoration: atividade.concluida
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removerAtividade(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
