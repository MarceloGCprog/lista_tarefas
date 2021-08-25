import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

late var file;
List lisTarefas = [];

// Função Principal
void main() {
  runApp(meuApp());
}

// Construção Stateful
class meuApp extends StatefulWidget {
  const meuApp({Key? key}) : super(key: key);

  @override
  _meuAppState createState() => _meuAppState();
}

class _meuAppState extends State<meuApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Lista de Tarefas",
        home: Scaffold(
            appBar: AppBar(title: Text("Titulo"), centerTitle: true),
            body: Text("CARALHO!")));
  }
}

Future getFile() async {
  final directory = await getApplicationDocumentsDirectory();
  return file("${directory.path}/data.json");
}

Future saveData() async {
  String data = jsonEncode(lisTarefas);
  final file = await getFile();
  return file.writeAsString(data);
}

Future<String> readData() async {
  try {
    final file = await getFile();
    return file.readAsString();
  } catch (e) {
    return "";
  }
}

/*Widget telaInicial() {
  return SingleChildScrollView(
      child: Scaffold(
          appBar: AppBar(title: Text("Titulo"), centerTitle: true),
          body: Text("CARALHO!")));
}*/
