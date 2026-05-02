import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/gerar_contrato_m/gerar_contrato_m_widget.dart';
import '/via_van/contrato_detalhe_m/contrato_detalhe_m_widget.dart';
import '../_vivan_http.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'contratos_lista_m_model.dart';
export 'contratos_lista_m_model.dart';

class ContratosListaMWidget extends StatefulWidget {
  const ContratosListaMWidget({
    super.key,
    this.passageiroId = 0,
    this.nomePassageiro = '',
  });

  final int passageiroId;
  final String nomePassageiro;

  static String routeName = 'contratosListaM';
  static String routePath = '/contratosLista';

  @override
  State<ContratosListaMWidget> createState() => _ContratosListaMWidgetState();
}

class _ContratosListaMWidgetState extends State<ContratosListaMWidget> {
  late ContratosListaMModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContratosListaMModel());
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _model.fetchContratos(
        FFAppState().idUsuario,
        passageiro: widget.passageiroId > 0 ? widget.passageiroId : null,
      );
      safeSetState(() {});
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Crie contratos do seu transporte escolar de forma rápida e segura, direto pelo Smartvan.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            fontSize: 16, color: _secondaryText),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Nesta etapa, você pode:',
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _primaryText),
                      ),
                      const SizedBox(height: 12),
                      _bullet('Visualizar como está o seu modelo de contrato'),
                      _bullet(
                          'Visualizar a lista de contratos já gerados para seus passageiros'),
                      _bullet('Ajustar cláusulas conforme sua necessidade'),
                      _bullet(
                          'Voltar ao modelo padrão do Smartvan quando precisar'),
                      const SizedBox(height: 16),
                      Text(
                        'Depois de gerar o contrato, é só enviar o link para o responsável assinar digitalmente. Simples e sem papelada.',
                        style: GoogleFonts.inter(
                            fontSize: 14, color: _secondaryText),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GerarContratoMWidget(
                                  passageiroId: widget.passageiroId,
                                  nomePassageiro: widget.nomePassageiro,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Novo Contrato',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: _openVerModelo,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Ver Modelo Atual',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: _showEditarContratoSheet,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Editar Contrato',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () => _confirmRestoreDefault(),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _primaryText,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                          ),
                          child: Text('Voltar Modelo Padrão',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
            child: Text('Voltar',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w500),
                      color: _primary)),
          ),
          Expanded(
            child: Center(
              child: Text('Gerar Contrato',
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
            ),
          ),
          GestureDetector(
            onTap: () => _showTutorial(),
            child: Text('Como Usar?',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: _primary)),
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text,
                style: GoogleFonts.inter(
                    fontSize: 14, color: _secondaryText)),
          ),
        ],
      ),
    );
  }

  void _openVerModelo() {
    final contrato = _model.contratoAtivo;
    if (contrato == null || contrato.idContrato == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum contrato ativo encontrado')));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ContratoDetalheMWidget(contratoId: contrato.idContrato),
      ),
    );
  }

  void _showEditarContratoSheet() {
    final contrato = _model.contratoAtivo;
    if (contrato == null || contrato.idContrato == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum contrato ativo encontrado')));
      return;
    }

    final valorCtrl = TextEditingController(
        text: contrato.valMensal?.toStringAsFixed(2) ?? '');
    int? diaVenc = contrato.diaVencimento;
    bool isSaving = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheet) => Padding(
          padding: EdgeInsets.fromLTRB(
              24, 20, 24, MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Editar Contrato',
                  style: GoogleFonts.interTight(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _primaryText)),
              const SizedBox(height: 16),
              Text('Valor Mensal (R\$)',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: _secondaryText)),
              const SizedBox(height: 6),
              TextFormField(
                controller: valorCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: '0,00',
                  prefixText: 'R\$ ',
                  filled: true,
                  fillColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: _primary, width: 1.5)),
                ),
              ),
              const SizedBox(height: 16),
              Text('Dia de Vencimento',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: _secondaryText)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: () async {
                  int? temp = diaVenc;
                  await showModalBottomSheet(
                    context: ctx,
                    backgroundColor: _bg,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20))),
                    builder: (_) => StatefulBuilder(
                      builder: (_, setD) => Padding(
                        padding:
                            const EdgeInsets.fromLTRB(24, 20, 24, 32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Dia de Vencimento',
                                style: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: _primaryText)),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 180,
                              child: ListWheelScrollView.useDelegate(
                                itemExtent: 44,
                                physics:
                                    const FixedExtentScrollPhysics(),
                                controller: FixedExtentScrollController(
                                    initialItem: (temp ?? 1) - 1),
                                onSelectedItemChanged: (i) =>
                                    setD(() => temp = i + 1),
                                childDelegate:
                                    ListWheelChildBuilderDelegate(
                                  childCount: 31,
                                  builder: (_, i) => Center(
                                    child: Text('Dia ${i + 1}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: temp == i + 1
                                                ? _primary
                                                : _secondaryText,
                                            fontWeight: temp == i + 1
                                                ? FontWeight.w700
                                                : FontWeight.normal)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                setSheet(() => diaVenc = temp ?? 1);
                                Navigator.pop(ctx);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _primary,
                                  minimumSize:
                                      const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12))),
                              child: const Text('Confirmar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Text(
                    diaVenc != null ? 'Dia $diaVenc de cada mês' : 'Selecionar',
                    style: GoogleFonts.inter(
                        color: diaVenc != null
                            ? _primaryText
                            : _secondaryText),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        final valor = double.tryParse(
                            valorCtrl.text.replaceAll(',', '.'));
                        if (valor == null) return;
                        setSheet(() => isSaving = true);
                        try {
                          await VivanHttp.put(
                              '/contratos/${contrato.idContrato}', {
                            'valMensal': valor,
                            if (diaVenc != null) 'diaVencimento': diaVenc,
                          });
                          await _model.fetchContratos(
                            FFAppState().idUsuario,
                            passageiro: widget.passageiroId > 0
                                ? widget.passageiroId
                                : null,
                          );
                          if (ctx.mounted) Navigator.pop(ctx);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: const Text(
                                        'Contrato atualizado!'),
                                    backgroundColor: _primary));
                          }
                        } catch (e) {
                          setSheet(() => isSaving = false);
                          if (ctx.mounted) {
                            ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                content: Text(
                                    'Erro: ${e.toString().replaceFirst('Exception: ', '')}')));
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Salvar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTutorial() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Como Usar os Contratos',
                style: GoogleFonts.interTight(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: _primaryText)),
            const SizedBox(height: 16),
            Text(
              '1. Toque em "Novo Contrato" para iniciar o assistente de criação.\n\n'
              '2. Preencha as informações do motorista, passageiro, responsável e valores.\n\n'
              '3. Assine digitalmente na etapa final e gere o contrato.\n\n'
              '4. Compartilhe o link com o responsável para que ele assine digitalmente.\n\n'
              '5. Use "Ver Modelo Atual" para revisar o modelo antes de gerar.',
              style: GoogleFonts.inter(fontSize: 14, color: _secondaryText),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Entendi',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmRestoreDefault() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Voltar Modelo Padrão',
            style: GoogleFonts.interTight(fontWeight: FontWeight.w700)),
        content: Text(
            'Deseja restaurar o modelo padrão do Smartvan? As personalizações serão perdidas.',
            style: GoogleFonts.inter(fontSize: 14)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Modelo padrão restaurado')));
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
}
