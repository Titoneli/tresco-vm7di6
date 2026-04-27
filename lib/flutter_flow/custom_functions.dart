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
