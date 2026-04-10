// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert' show utf8;
import 'package:download/download.dart';

/// download: ^0.0.1+1
Future downloadToAnyPlatfromCSVAlunos(
    String? nomeEscola, String sitAluno) async {
  // 1️⃣ Cria a query base
  //var query = Supabase.instance.client.from('listagemescolaalunos').select();

  // 4️⃣ Executa query
  final rows = await Supabase.instance.client
      .from('listagemescolaalunos')
      .select()
      .range(0, 49999);

  //final rows = await query.range(0, 49999);

  if (rows.isEmpty) {
    print('[CSV Export] Nenhum registro encontrado.');
    return;
  }

  final listagemEscolaAlunos =
      rows.map((json) => ListagemescolaalunosRow(json)).toList();

  String companyName = "CooperTransMig";
  String companyAddress = "Tresco";
  String header = "$companyName,$companyAddress\n";
  String fileContent = header + "Aluno,Escola,Turno,Situacao,Motorista\n";

  fileContent += listagemEscolaAlunos
      .map((r) =>
          "${r.nomeAluno},${r.nomeEscola},${r.domTurno},${r.domSitAluno},${r.nomeUsuario}")
      .join("\n");

  var bytes = utf8.encode('\uFEFF' + fileContent);
  final fileName = "TrescoLstAlunosGeral" + DateTime.now().toString() + ".csv";

  final stream = Stream.fromIterable(bytes);
  return download(stream, fileName);
}
