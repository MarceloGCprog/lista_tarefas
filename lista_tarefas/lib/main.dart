import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

late var file;
List lisTarefas = [];
TextEditingController controLista = new TextEditingController();

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
  void addLista() {
    setState(() {
      // Cria o mapa dentro da funcao p/ cada novo add
      Map<String, dynamic> mapLista = new Map();
      mapLista["texto"] = controLista.text;
      mapLista["check"] = false;
      lisTarefas.add(mapLista);
      controLista.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Lista de Tarefas", home: telaInicial());
  }

  Widget telaInicial() {
    return Scaffold(
        appBar: AppBar(title: Text("Lista de Tarefas"), centerTitle: true),
        body: Column(children: [
          Container(
              padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
              child: Row(children: [
                Expanded(
                    child: TextField(
                  controller: controLista,
                  decoration: InputDecoration(
                      labelText: "Digite a nova tarefa",
                      labelStyle:
                          TextStyle(color: Colors.blueAccent, fontSize: 25.0)),
                )),
                ElevatedButton(onPressed: addLista, child: Text("ADD"))
              ])),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 10),
            itemCount: lisTarefas.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                  secondary: CircleAvatar(
                    child: Icon(
                        lisTarefas[index]["check"] ? Icons.check : Icons.error),
                  ),
                  title: Text(lisTarefas[index]["texto"]),
                  //controlAffinity: ListTileControlAffinity.leading,
                  value: lisTarefas[index]["check"],
                  onChanged: (c) {
                    setState(() {
                      lisTarefas[index]["check"] = c;
                    });
                  });
            },
          ))
        ]));
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
