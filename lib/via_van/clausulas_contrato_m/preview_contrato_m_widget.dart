import 'dart:io';
import 'dart:typed_data';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'clausula_storage.dart';

class PreviewContratoMWidget extends StatefulWidget {
  const PreviewContratoMWidget({
    super.key,
    required this.passageiroId,
    required this.nomePassageiro,
    this.pdfPath,
    this.nomeResponsavel = '',
    this.valMensal,
    this.dtInicio,
    this.dtTermino,
    this.diaVencimento,
  });

  final int passageiroId;
  final String nomePassageiro;
  final String? pdfPath;
  final String nomeResponsavel;
  final double? valMensal;
  final DateTime? dtInicio;
  final DateTime? dtTermino;
  final int? diaVencimento;

  @override
  State<PreviewContratoMWidget> createState() => _PreviewContratoMWidgetState();
}

class _PreviewContratoMWidgetState extends State<PreviewContratoMWidget> {
  bool _isGenerating = false;
  String? _pdfPath;
  String? _errorMessage;

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  void initState() {
    super.initState();
    if (widget.pdfPath != null) {
      _pdfPath = widget.pdfPath;
    } else {
      _gerarPdf();
    }
  }

  Future<void> _gerarPdf() async {
    if (_isGenerating) return;
    setState(() { _isGenerating = true; _errorMessage = null; });
    try {
      // Verificar/configurar cidade
      String? cidade = await MotoristaCidade.load();
      if (cidade == null && mounted) {
        cidade = await _pedirCidade();
        if (cidade != null) await MotoristaCidade.save(cidade);
      }

      final clausulas = await ClausulaStorage.load();
      final sigBytes = await SignatureStorage.load();

      // Carregar fonte
      pw.Font? font;
      pw.Font? fontBold;
      try {
        final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
        font = pw.Font.ttf(fontData);
        // Roboto bold não está nos assets — usar helvetica bold como fallback
        fontBold = null;
      } catch (_) {
        font = null;
        fontBold = null;
      }

      final pdf = await _buildPdf(clausulas, cidade, sigBytes, font, fontBold);
      final bytes = await pdf.save();

      final path = await PdfStorage.pdfPath(widget.passageiroId);
      await File(path).writeAsBytes(bytes);

      final hash = PdfStorage.hashOf(clausulas);
      await PdfStorage.saveMeta(
        widget.passageiroId,
        PdfMeta(
          filePath: path,
          geradoEm: DateTime.now(),
          clausulasHash: hash,
        ),
      );

      if (mounted) setState(() { _pdfPath = path; _isGenerating = false; });
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = 'Erro ao gerar PDF: ${e.toString().replaceFirst('Exception: ', '')}';
          _isGenerating = false;
        });
      }
    }
  }

  Future<String?> _pedirCidade() async {
    final ctrl = TextEditingController();
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text('Cidade do motorista',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Informe a cidade para constar no contrato (ex: São Paulo).',
              style: GoogleFonts.inter(fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: ctrl,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Ex: São Paulo',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, null),
              child: const Text('Pular')),
          ElevatedButton(
            onPressed: () {
              final v = ctrl.text.trim();
              Navigator.pop(ctx, v.isEmpty ? null : v);
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: FlutterFlowTheme.of(context).primary),
            child: Text('Confirmar',
                style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Future<pw.Document> _buildPdf(
    List<ClausulaModelo> clausulas,
    String? cidade,
    Uint8List? sigBytes,
    pw.Font? font,
    pw.Font? fontBold,
  ) async {
    final pdf = pw.Document();

    final nomeMotorista = FFAppState().nomeUsuario.isNotEmpty
        ? FFAppState().nomeUsuario
        : 'CONTRATADO(A)';
    final nomeResponsavel = widget.nomeResponsavel.isNotEmpty
        ? widget.nomeResponsavel
        : 'CONTRATANTE';
    final valMensal = widget.valMensal ?? 0.0;
    final diaVenc = widget.diaVencimento ?? 5;
    final dtInicio = widget.dtInicio;
    final dtTermino = widget.dtTermino;

    final cidadeStr = cidade ?? '______';
    final dataContrato = dtInicio != null
        ? _dataExtenso(dtInicio)
        : _dataExtenso(DateTime.now());

    String sub(String texto) {
      return texto
          .replaceAll('[NOME_CONTRATANTE]', nomeResponsavel)
          .replaceAll('[NOME_CONTRATADO]', nomeMotorista)
          .replaceAll('[VALOR_TOTAL]',
              NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(valMensal))
          .replaceAll('[VALOR_EXTENSO]', valorPorExtenso(valMensal))
          .replaceAll('[DIA_VENCIMENTO]', '$diaVenc')
          .replaceAll(
              '[DT_INICIO]',
              dtInicio != null
                  ? DateFormat('dd/MM/yyyy').format(dtInicio)
                  : '____/____')
          .replaceAll(
              '[DT_FIM]',
              dtTermino != null
                  ? DateFormat('dd/MM/yyyy').format(dtTermino)
                  : '____/____')
          .replaceAll('[CIDADE]', cidadeStr)
          .replaceAll('[DATA_CONTRATO]', dataContrato);
    }

    final baseStyle = font != null
        ? pw.TextStyle(font: font, fontSize: 10, lineSpacing: 2)
        : pw.TextStyle(fontSize: 10, lineSpacing: 2);
    final boldStyle = fontBold != null
        ? pw.TextStyle(font: fontBold, fontSize: 10, fontWeight: pw.FontWeight.bold)
        : baseStyle.copyWith(fontWeight: pw.FontWeight.bold);
    final titleStyle = boldStyle.copyWith(fontSize: 14);
    final sectionStyle = boldStyle.copyWith(fontSize: 11, letterSpacing: 0.5);

    // Assinatura como imagem pw
    pw.ImageProvider? sigImage;
    if (sigBytes != null) {
      try {
        sigImage = pw.MemoryImage(sigBytes);
      } catch (_) {
        sigImage = null;
      }
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(56),
        build: (ctx) {
          final widgets = <pw.Widget>[];

          // Título
          widgets.add(pw.Center(
            child: pw.Text(
              'CONTRATO DE PRESTAÇÃO DE SERVIÇOS\nDE TRANSPORTE ESCOLAR',
              textAlign: pw.TextAlign.center,
              style: titleStyle,
            ),
          ));
          widgets.add(pw.SizedBox(height: 16));

          // Dados das partes
          widgets.add(pw.Text('CONTRATADO(A)', style: sectionStyle));
          widgets.add(pw.SizedBox(height: 4));
          widgets.add(pw.Text('Nome: $nomeMotorista', style: baseStyle));
          widgets.add(pw.SizedBox(height: 12));

          widgets.add(pw.Text('CONTRATANTE / RESPONSÁVEL', style: sectionStyle));
          widgets.add(pw.SizedBox(height: 4));
          widgets.add(pw.Text('Nome: $nomeResponsavel', style: baseStyle));
          widgets.add(pw.SizedBox(height: 4));
          widgets.add(pw.Text('Aluno(a): ${widget.nomePassageiro}', style: baseStyle));
          widgets.add(pw.SizedBox(height: 4));
          if (dtInicio != null) {
            widgets.add(pw.Text(
                'Vigência: ${DateFormat('dd/MM/yyyy').format(dtInicio)} a ${dtTermino != null ? DateFormat('dd/MM/yyyy').format(dtTermino) : "____/____"}',
                style: baseStyle));
          }
          widgets.add(pw.SizedBox(height: 16));
          widgets.add(pw.Divider());
          widgets.add(pw.SizedBox(height: 12));

          // Cláusulas por seção
          for (final secao in ClausulaStorage.secoes) {
            final daSec = clausulas.where((c) => c.secao == secao).toList();
            if (daSec.isEmpty) continue;

            widgets.add(pw.Text(secao, style: sectionStyle));
            widgets.add(pw.SizedBox(height: 8));

            for (final c in daSec) {
              final num = ClausulaStorage.numeroGlobal(clausulas, c);
              final textoSubst = sub(c.texto);
              widgets.add(
                pw.RichText(
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                          text: 'Cláusula ${_ordinal(num)} — ',
                          style: boldStyle.copyWith(fontSize: 10)),
                      pw.TextSpan(text: textoSubst, style: baseStyle),
                    ],
                  ),
                ),
              );
              widgets.add(pw.SizedBox(height: 8));
            }
            widgets.add(pw.SizedBox(height: 4));
          }

          // Assinaturas
          widgets.add(pw.SizedBox(height: 24));
          widgets.add(pw.Divider());
          widgets.add(pw.SizedBox(height: 12));
          widgets.add(pw.Text(
            '$cidadeStr, $dataContrato',
            style: baseStyle,
            textAlign: pw.TextAlign.right,
          ));
          widgets.add(pw.SizedBox(height: 32));

          // Linha CONTRATADO(A)
          if (sigImage != null) {
            widgets.add(pw.Center(
              child: pw.Image(sigImage, height: 60, width: 200),
            ));
            widgets.add(pw.SizedBox(height: 4));
          } else {
            widgets.add(pw.SizedBox(height: 64));
          }
          widgets.add(pw.Center(
            child: pw.Container(
              width: 240,
              decoration: const pw.BoxDecoration(
                border: pw.Border(top: pw.BorderSide(width: 0.5)),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(top: 4),
                child: pw.Center(
                    child: pw.Text('CONTRATADO(A)', style: baseStyle)),
              ),
            ),
          ));
          widgets.add(pw.SizedBox(height: 32));

          // Linha CONTRATANTE
          widgets.add(pw.SizedBox(height: 64));
          widgets.add(pw.Center(
            child: pw.Container(
              width: 240,
              decoration: const pw.BoxDecoration(
                border: pw.Border(top: pw.BorderSide(width: 0.5)),
              ),
              child: pw.Padding(
                padding: const pw.EdgeInsets.only(top: 4),
                child: pw.Center(
                    child: pw.Text('CONTRATANTE', style: baseStyle)),
              ),
            ),
          ));

          return widgets;
        },
      ),
    );

    return pdf;
  }

  Future<void> _share() async {
    if (_pdfPath == null) return;
    final bytes = await File(_pdfPath!).readAsBytes();
    final nomeFile =
        'Contrato_${widget.nomePassageiro.replaceAll(' ', '_')}_${DateTime.now().year}.pdf';
    await Printing.sharePdf(bytes: bytes, filename: nomeFile);
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: _bg,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text('Fechar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text(
                _isGenerating ? 'Gerando PDF...' : 'Contrato',
                style: FlutterFlowTheme.of(context).titleMedium.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText),
              ),
            ),
          ),
          if (_pdfPath != null)
            GestureDetector(
              onTap: _share,
              child: Icon(Icons.share_outlined, color: _primary, size: 22),
            )
          else
            const SizedBox(width: 22),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_isGenerating) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: _primary, strokeWidth: 2),
            const SizedBox(height: 16),
            Text('Gerando contrato...',
                style: GoogleFonts.inter(color: _secondaryText)),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade400, size: 48),
              const SizedBox(height: 16),
              Text(_errorMessage!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: _secondaryText)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _gerarPdf,
                style: ElevatedButton.styleFrom(backgroundColor: _primary),
                child: Text('Tentar novamente',
                    style: GoogleFonts.inter(color: Colors.white)),
              ),
            ],
          ),
        ),
      );
    }

    if (_pdfPath == null) return const SizedBox.shrink();

    return SfPdfViewer.file(File(_pdfPath!));
  }

  String _dataExtenso(DateTime d) {
    const meses = [
      'janeiro', 'fevereiro', 'março', 'abril', 'maio', 'junho',
      'julho', 'agosto', 'setembro', 'outubro', 'novembro', 'dezembro',
    ];
    return '${d.day} de ${meses[d.month - 1]} de ${d.year}';
  }

  String _ordinal(int n) {
    return '$nª';
  }
}
