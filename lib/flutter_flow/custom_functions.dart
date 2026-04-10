import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:ff_commons/flutter_flow/lat_lng.dart';
import 'package:ff_commons/flutter_flow/place.dart';
import 'package:ff_commons/flutter_flow/uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';

LatLng makeLatLon(
  String lat,
  String lon,
) {
  return LatLng(double.parse(lat), double.parse(lon));
}

LatLng parseLatLngFromString(String latLngString) {
  try {
    final regex = RegExp(r'LatLng\(lat: ([\-0-9.]+), lng: ([\-0-9.]+)\)');
    final match = regex.firstMatch(latLngString);
    if (match != null) {
      final latitude = double.parse(match.group(1)!);
      final longitude = double.parse(match.group(2)!);
      return LatLng(latitude, longitude);
    } else {
      throw FormatException('Formato inválido de LatLng.');
    }
  } catch (e) {
    print('Erro ao converter String para LatLng: $e');
    return LatLng(-14.2350, -51.9253); // Retorno padrão seguro
  }
}

String? getCurrentMonthYear() {
  final now = DateTime.now();
  return '${now.month.toString().padLeft(2, '0')}/${now.year}';
}

/// Formata um valor monetário para o padrão brasileiro R$ #.###,##
/// Aceita String (ex: "2.312,4", "3190.8", "2898") ou num.
/// Sempre retorna com 2 casas decimais: "R$ 2.312,40", "R$ 3.190,80".
String formatBRL(dynamic value, {bool showSymbol = true}) {
  if (value == null) return showSymbol ? 'R\$ 0,00' : '0,00';

  double numValue;
  if (value is num) {
    numValue = value.toDouble();
  } else {
    String s = value.toString().trim();
    if (s.isEmpty) return showSymbol ? 'R\$ 0,00' : '0,00';
    // Detectar formato: se contém vírgula, é formato BR (1.234,56)
    if (s.contains(',')) {
      // Formato brasileiro: remover pontos de milhar, trocar vírgula por ponto
      s = s.replaceAll('.', '').replaceAll(',', '.');
    }
    numValue = double.tryParse(s) ?? 0.0;
  }

  final formatter = NumberFormat('#,##0.00', 'pt_BR');
  final formatted = formatter.format(numValue);
  return showSymbol ? 'R\$ $formatted' : formatted;
}
