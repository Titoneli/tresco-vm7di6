import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> validarAtf(String atfId) async {
  try {
    // URL do webhook n8n (ajuste conforme seu ambiente)
    const webhookUrl = 'YOUR_N8N_WEBHOOK_URL/validar-atf';
    
    final response = await http.post(
      Uri.parse(webhookUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'atf_id': atfId}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      
      // Atualizar status se validado
      if (result['valido'] == true) {
        await AtfTable().update(
          data: {'status': 'validado'},
          matchingRows: (rows) => rows.eq('id', atfId),
        );
      }
      
      return {
        'success': true,
        'valido': result['valido'] ?? false,
        'erros': result['erros'] ?? [],
      };
    } else {
      return {
        'success': false,
        'valido': false,
        'erros': ['Erro ao conectar com o serviço de validação'],
      };
    }
  } catch (e) {
    return {
      'success': false,
      'valido': false,
      'erros': ['Erro: ${e.toString()}'],
    };
  }
}