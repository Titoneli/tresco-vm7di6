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
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

/// download: ^0.0.1+1
Future csvAlunosAPI(String? nomeEscola, String sitAluno) async {
  // Cria a query base
  //var query = Supabase.instance.client.from('listagemescolaalunos').select();

  try {
    final url = Uri.parse(
        'https://webhook.n8ncp.vigicar.com.br/webhook/retornalistagemalunos'); // substitua pela URL da API
    final response = await http.get(url);

    if (response.statusCode != 200) {
      print('Erro na requisição: ${response.statusCode}');
      return [];
    }

    final data = jsonDecode(response.body) as List<dynamic>;

    // converte JSON para suas rows (se tiver classe gerada)
    List<ListagemescolaalunosRow> alunos = data
        .map((json) => ListagemescolaalunosRow(json as Map<String, dynamic>))
        .toList();

    // Executa query
    //final rows = await Supabase.instance.client
    //    .from('listagemescolaalunos')
    //    .select()
    //    .range(0, 49999);

    //final rows = await query.range(0, 49999);

    //if (rows.isEmpty) {
    //  print('[CSV Export] Nenhum registro encontrado.');
    //  return;
    //}

    //final listagemEscolaAlunos =
    //    rows.map((json) => ListagemescolaalunosRow(json)).toList();

    String companyName = "CooperTransMig";
    String companyAddress = "Tresco";
    String header = "$companyName,$companyAddress\n";
    String fileContent = header + "Aluno,Escola,Turno,Situacao,Motorista\n";

    fileContent += alunos
        .map((r) =>
            "${r.nomeAluno},${r.nomeEscola},${r.domTurno},${r.domSitAluno},${r.nomeUsuario}")
        .join("\n");

    var bytes = utf8.encode('\uFEFF' + fileContent);
    final fileName =
        "TrescoLstAlunosGeral" + DateTime.now().toString() + ".csv";

    final stream = Stream.fromIterable(bytes);
    return download(stream, fileName);
  } catch (e) {
    print('Erro ao buscar dados da API: $e');
    return [];
  }
}
