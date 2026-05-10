import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Model
// ─────────────────────────────────────────────────────────────────────────────

class ClausulaModelo {
  String id;
  String secao;
  String texto;
  bool isCustom;

  ClausulaModelo({
    required this.id,
    required this.secao,
    required this.texto,
    this.isCustom = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'secao': secao,
        'texto': texto,
        'isCustom': isCustom,
      };

  factory ClausulaModelo.fromJson(Map<String, dynamic> j) => ClausulaModelo(
        id: j['id'] as String,
        secao: j['secao'] as String,
        texto: j['texto'] as String,
        isCustom: j['isCustom'] as bool? ?? false,
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// ClausulaStorage
// ─────────────────────────────────────────────────────────────────────────────

class ClausulaStorage {
  static const _prefsKey = 'clausulas_contrato_v1';

  static List<String> get secoes => const [
        'DO OBJETO',
        'DA PRESTAÇÃO DO SERVIÇO',
        'DO VALOR',
        'DA RESCISÃO',
        'DAS DISPOSIÇÕES FINAIS',
      ];

  static const variaveis = [
    '[NOME_CONTRATANTE]',
    '[NOME_CONTRATADO]',
    '[VALOR_TOTAL]',
    '[VALOR_EXTENSO]',
    '[DIA_VENCIMENTO]',
    '[DT_INICIO]',
    '[DT_FIM]',
    '[CIDADE]',
    '[DATA_CONTRATO]',
  ];

  static List<ClausulaModelo> get defaults => [
        // DO OBJETO
        ClausulaModelo(
          id: 'default_01',
          secao: 'DO OBJETO',
          texto:
              'O serviço contratado consiste no transporte do aluno acima citado, no trajeto com origem e destino acordado entre as partes.',
        ),
        // DA PRESTAÇÃO DO SERVIÇO
        ClausulaModelo(
          id: 'default_02',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'Somente o aluno CONTRATANTE está autorizado a utilizar-se do objeto deste contrato, sendo vedado o aluno se fazer acompanhar de colegas, parentes, amigos e etc.',
        ),
        ClausulaModelo(
          id: 'default_03',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'O transporte ora contratado se refere exclusivamente ao horário regular da escola pré-determinado, não sendo de responsabilidade da CONTRATADA o transporte do aluno em turno diferente do contratado, em horários de atividades extracurriculares ou que por determinação da escola seja alterado.',
        ),
        ClausulaModelo(
          id: 'default_04',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'O procedimento de retirada e entrega do aluno na residência ou local combinado deverá ser acordado entre as partes, definindo um responsável para acompanhar o aluno.',
        ),
        ClausulaModelo(
          id: 'default_05',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'A partir do momento que for realizada a entrega do aluno na escola, a CONTRATADA não é mais responsável pela segurança do aluno, bem como de seus pertences.',
        ),
        ClausulaModelo(
          id: 'default_06',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'As partes deverão respeitar os horários previamente combinados de saída dos locais de origem e destino, ficando estabelecido que, caso ocorra mudança no local de origem, destino ou retorno, a CONTRATADA reserva-se o direito de aceitar ou não tais alterações, em razão da modificação de rota, podendo, inclusive, ficar desobrigada da prestação dos serviços previstos neste contrato.',
        ),
        ClausulaModelo(
          id: 'default_07',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'Fica estabelecido que, caso a CONTRATANTE ou algum outro responsável pelo aluno for buscá-lo no lugar da CONTRATADA, a CONTRATANTE deverá comunicar à CONTRATADA e à escola previamente.',
        ),
        ClausulaModelo(
          id: 'default_08',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'A CONTRATANTE obriga-se a informar a CONTRATADA com um prazo de até duas horas antes do horário se o aluno não for comparecer à escola naquele dia.',
        ),
        ClausulaModelo(
          id: 'default_09',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'Está proibido o consumo de alimentos no interior do veículo escolar, com a finalidade de evitar e prevenir acidentes, como engasgos, ou constrangimento de outros alunos, além de manter a limpeza do veículo.',
        ),
        ClausulaModelo(
          id: 'default_10',
          secao: 'DA PRESTAÇÃO DO SERVIÇO',
          texto:
              'Para os efeitos deste contrato, o transporte pactuado ficará temporariamente suspenso no caso de o aluno apresentar doença infectocontagiosa, visando preservar a saúde e a segurança das crianças transportadas e dos prestadores do serviço.',
        ),
        // DO VALOR
        ClausulaModelo(
          id: 'default_11',
          secao: 'DO VALOR',
          texto:
              'A CONTRATANTE pagará à CONTRATADA o valor total de R\$ [VALOR_TOTAL] ([VALOR_EXTENSO]), conforme forma de pagamento e parcelamento previamente acordados entre as partes, sendo o pagamento devido integralmente e de forma regular inclusive durante os períodos de férias dos meses de julho, dezembro e janeiro, bem como em casos de recessos breves, afastamento temporário do aluno por motivo de doença, férias escolares ou qualquer outro motivo.',
        ),
        // DA RESCISÃO
        ClausulaModelo(
          id: 'default_12',
          secao: 'DA RESCISÃO',
          texto:
              'O presente contrato poderá ser rescindido por qualquer das partes, desde que haja comunicação prévia de 30 (trinta) dias.',
        ),
        ClausulaModelo(
          id: 'default_13',
          secao: 'DA RESCISÃO',
          texto:
              'Em caso de rescisão por iniciativa da CONTRATANTE, esta deverá pagar as parcelas vencidas e as que vencerem dentro do prazo de aviso prévio de 30 dias.',
        ),
        ClausulaModelo(
          id: 'default_14',
          secao: 'DA RESCISÃO',
          texto:
              'Em caso de rescisão por iniciativa da CONTRATADA, esta deverá devolver os valores pagos proporcionalmente aos dias não prestados, deduzidas as parcelas pendentes, exceto quando a rescisão for motivada.',
        ),
        // DAS DISPOSIÇÕES FINAIS
        ClausulaModelo(
          id: 'default_15',
          secao: 'DAS DISPOSIÇÕES FINAIS',
          texto:
              'A CONTRATADA deverá prestar os serviços solicitados pela CONTRATANTE com observância das normas de trânsito, prezando pela segurança e bem-estar do aluno.',
        ),
        ClausulaModelo(
          id: 'default_16',
          secao: 'DAS DISPOSIÇÕES FINAIS',
          texto:
              'É convencionado que a CONTRATADA não será responsabilizada pela vigilância de objetos pessoais, material escolar, dinheiro, joias ou quaisquer pertences eventualmente esquecidos pelo aluno no veículo ou no estabelecimento escolar.',
        ),
        ClausulaModelo(
          id: 'default_17',
          secao: 'DAS DISPOSIÇÕES FINAIS',
          texto:
              'As partes reconhecem o presente contrato como título executivo extrajudicial nos termos do artigo 784, XI, do Código de Processo Civil, sem prejuízo da opção pelo processo de conhecimento para obtenção de título executivo judicial, nos termos do artigo 785.',
        ),
      ];

  static Future<List<ClausulaModelo>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_prefsKey);
    if (json == null || json.isEmpty) return List.from(defaults);
    try {
      final list = jsonDecode(json) as List;
      return list.map((e) => ClausulaModelo.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return List.from(defaults);
    }
  }

  static Future<void> save(List<ClausulaModelo> clausulas) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(clausulas.map((c) => c.toJson()).toList()));
  }

  static Future<void> resetToDefaults() async {
    await save(List.from(defaults));
  }

  static int numeroGlobal(List<ClausulaModelo> all, ClausulaModelo m) {
    return all.indexOf(m) + 1;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PdfMeta + PdfStorage
// ─────────────────────────────────────────────────────────────────────────────

class PdfMeta {
  final String filePath;
  final DateTime geradoEm;
  final String clausulasHash;

  PdfMeta({
    required this.filePath,
    required this.geradoEm,
    required this.clausulasHash,
  });

  Map<String, dynamic> toJson() => {
        'filePath': filePath,
        'geradoEm': geradoEm.toIso8601String(),
        'clausulasHash': clausulasHash,
      };

  factory PdfMeta.fromJson(Map<String, dynamic> j) => PdfMeta(
        filePath: j['filePath'] as String,
        geradoEm: DateTime.parse(j['geradoEm'] as String),
        clausulasHash: j['clausulasHash'] as String,
      );
}

class PdfStorage {
  static const _prefsKey = 'pdf_contratos_v2';

  static Future<Map<String, dynamic>> _loadMap() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_prefsKey);
    if (json == null || json.isEmpty) return {};
    try {
      return Map<String, dynamic>.from(jsonDecode(json) as Map);
    } catch (_) {
      return {};
    }
  }

  static Future<void> _saveMap(Map<String, dynamic> map) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(map));
  }

  static Future<PdfMeta?> getMeta(int passageiroId) async {
    final map = await _loadMap();
    final entry = map['$passageiroId'];
    if (entry == null) return null;
    try {
      return PdfMeta.fromJson(Map<String, dynamic>.from(entry as Map));
    } catch (_) {
      return null;
    }
  }

  static Future<void> saveMeta(int passageiroId, PdfMeta meta) async {
    final map = await _loadMap();
    map['$passageiroId'] = meta.toJson();
    await _saveMap(map);
  }

  static Future<void> remove(int passageiroId) async {
    final map = await _loadMap();
    final meta = map.remove('$passageiroId');
    await _saveMap(map);
    if (meta != null) {
      try {
        final m = PdfMeta.fromJson(Map<String, dynamic>.from(meta as Map));
        final f = File(m.filePath);
        if (await f.exists()) await f.delete();
      } catch (_) {}
    }
  }

  static Future<bool> isStale(int passageiroId, List<ClausulaModelo> clausulasAtuais) async {
    final meta = await getMeta(passageiroId);
    if (meta == null) return false;
    return meta.clausulasHash != _hash(clausulasAtuais);
  }

  static String _hash(List<ClausulaModelo> clausulas) {
    final data = jsonEncode(clausulas.map((c) => c.toJson()).toList());
    return sha256.convert(utf8.encode(data)).toString();
  }

  static String hashOf(List<ClausulaModelo> clausulas) => _hash(clausulas);

  static Future<String> pdfDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final contratos = Directory('${dir.path}/contratos');
    if (!await contratos.exists()) await contratos.create(recursive: true);
    return contratos.path;
  }

  static Future<String> pdfPath(int passageiroId) async {
    final dir = await pdfDir();
    return '$dir/contrato_$passageiroId.pdf';
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SignatureStorage
// ─────────────────────────────────────────────────────────────────────────────

class SignatureStorage {
  static const _filename = 'assinatura_motorista.png';

  static Future<String> _path() async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/$_filename';
  }

  static Future<Uint8List?> load() async {
    try {
      final f = File(await _path());
      if (!await f.exists()) return null;
      return await f.readAsBytes();
    } catch (_) {
      return null;
    }
  }

  static Future<void> save(Uint8List pngBytes) async {
    final f = File(await _path());
    await f.writeAsBytes(pngBytes);
  }

  static Future<void> remove() async {
    try {
      final f = File(await _path());
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }

  static Future<bool> exists() async {
    try {
      return await File(await _path()).exists();
    } catch (_) {
      return false;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// MotoristaCidade
// ─────────────────────────────────────────────────────────────────────────────

class MotoristaCidade {
  static const _prefsKey = 'cidade_motorista';

  static Future<String?> load() async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_prefsKey);
    return (v == null || v.isEmpty) ? null : v;
  }

  static Future<void> save(String cidade) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, cidade);
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// valorPorExtenso — converte double para texto PT-BR
// Cobertura: R$ 0,00 até R$ 999.999,99
// ─────────────────────────────────────────────────────────────────────────────

String valorPorExtenso(double valor) {
  if (valor <= 0) return 'zero reais';

  final inteiro = valor.floor();
  final centavos = ((valor - inteiro) * 100).round();

  String texto = '';
  if (inteiro > 0) {
    texto = _inteiroExtenso(inteiro);
    texto += inteiro == 1 ? ' real' : ' reais';
  }
  if (centavos > 0) {
    if (texto.isNotEmpty) texto += ' e ';
    texto += _inteiroExtenso(centavos);
    texto += centavos == 1 ? ' centavo' : ' centavos';
  }
  return texto;
}

String _inteiroExtenso(int n) {
  if (n == 0) return 'zero';
  if (n < 0) return 'menos ${_inteiroExtenso(-n)}';

  const unidades = [
    '', 'um', 'dois', 'três', 'quatro', 'cinco', 'seis', 'sete', 'oito', 'nove',
    'dez', 'onze', 'doze', 'treze', 'quatorze', 'quinze', 'dezesseis',
    'dezessete', 'dezoito', 'dezenove',
  ];
  const dezenas = [
    '', '', 'vinte', 'trinta', 'quarenta', 'cinquenta', 'sessenta',
    'setenta', 'oitenta', 'noventa',
  ];
  const centenas = [
    '', 'cem', 'duzentos', 'trezentos', 'quatrocentos', 'quinhentos',
    'seiscentos', 'setecentos', 'oitocentos', 'novecentos',
  ];

  final parts = <String>[];

  if (n >= 1000) {
    final milhar = n ~/ 1000;
    if (milhar == 1) {
      parts.add('mil');
    } else {
      parts.add('${_inteiroExtenso(milhar)} mil');
    }
    n = n % 1000;
    if (n == 0) return parts.join(' e ');
  }

  if (n >= 100) {
    final c = n ~/ 100;
    if (n % 100 == 0) {
      parts.add(centenas[c]);
    } else if (c == 1) {
      parts.add('cento');
    } else {
      parts.add(centenas[c]);
    }
    n = n % 100;
    if (n == 0) return parts.join(' e ');
  }

  if (n >= 20) {
    parts.add(dezenas[n ~/ 10]);
    n = n % 10;
    if (n > 0) parts.add(unidades[n]);
  } else if (n > 0) {
    parts.add(unidades[n]);
  }

  return parts.join(' e ');
}
