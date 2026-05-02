import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/via_van/passageiro_detalhe_m/passageiro_detalhe_m_widget.dart';
import '/via_van/passageiro_form_m/passageiro_form_m_widget.dart';
import 'passageiros_tab_model.dart';
export 'passageiros_tab_model.dart';

class PassageirosTabWidget extends StatefulWidget {
  const PassageirosTabWidget({super.key});

  @override
  State<PassageirosTabWidget> createState() => _PassageirosTabWidgetState();
}

class _PassageirosTabWidgetState extends State<PassageirosTabWidget> {
  late PassageirosTabModel _model;

  @override
  void initState() {
    super.initState();
    _model = PassageirosTabModel();
    WidgetsBinding.instance.addPostFrameCallback((_) => _model.carregar());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Color get _primary => FlutterFlowTheme.of(context).primary;
  Color get _bg => FlutterFlowTheme.of(context).primaryBackground;
  Color get _secondBg => FlutterFlowTheme.of(context).secondaryBackground;
  Color get _primaryText => FlutterFlowTheme.of(context).primaryText;
  Color get _secondaryText => FlutterFlowTheme.of(context).secondaryText;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _model,
      builder: (context, _) => Column(
        children: [
          _buildHeader(),
          _buildSearch(),
          _buildFilterRow(),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Passageiros',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w700),
                      color: _primaryText),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'v8.1',
                  style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ],
          ),
          InkWell(
            borderRadius: BorderRadius.circular(24),
            onTap: () => _abrirForm(null),
            child: Container(
              width: 40,
              height: 40,
              decoration:
                  BoxDecoration(color: _primary, shape: BoxShape.circle),
              child: const Icon(Icons.person_add_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: _model.searchCtrl,
        focusNode: _model.searchFocus,
        onChanged: _model.setBusca,
        style: FlutterFlowTheme.of(context)
            .bodyMedium
            .override(font: GoogleFonts.inter(), color: _primaryText),
        decoration: InputDecoration(
          hintText: 'Buscar passageiro',
          hintStyle: FlutterFlowTheme.of(context)
              .bodyMedium
              .override(font: GoogleFonts.inter(), color: _secondaryText),
          prefixIcon:
              Icon(Icons.search_rounded, color: _secondaryText, size: 20),
          filled: true,
          fillColor: _secondBg,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: _primary, width: 1.5)),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: _filterButton(
              label: 'Período',
              active: _model.periodoFiltro != null,
              onTap: _showFiltroPeriodo,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _filterButton(
              label: 'Escola',
              active: _model.escolaFiltro != null,
              onTap: _showFiltroEscola,
            ),
          ),
          const SizedBox(width: 10),
          _countBadge(),
        ],
      ),
    );
  }

  Widget _filterButton(
      {required String label,
      required bool active,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _primary : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: active ? _primary : Colors.grey.shade400, width: 1.5),
        ),
        child: Text(
          label,
          style: FlutterFlowTheme.of(context).bodyMedium.override(
                font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                color: active ? Colors.white : _primaryText),
        ),
      ),
    );
  }

  Widget _countBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: _primary, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${_model.total}',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(fontWeight: FontWeight.w700),
                    color: Colors.white)),
          const SizedBox(width: 4),
          const Icon(Icons.people_rounded, color: Colors.white, size: 16),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_model.isLoading) {
      return Center(
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(_primary)));
    }
    if (_model.erro != null && _model.lista.isEmpty) {
      return _buildErro();
    }
    if (_model.lista.isEmpty) {
      return _buildVazio();
    }
    return RefreshIndicator(
      color: _primary,
      onRefresh: _model.carregar,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _model.lista.length,
        separatorBuilder: (_, __) =>
            Divider(height: 1, color: Colors.grey.shade200, indent: 72),
        itemBuilder: (_, i) => _buildItem(_model.lista[i]),
      ),
    );
  }

  Widget _buildItem(PassageiroTabItem p) {
    return InkWell(
      onTap: () => _abrirDetalhe(p.id),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            _avatar(p),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.nome,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font:
                              GoogleFonts.inter(fontWeight: FontWeight.w600),
                          color: _primaryText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (p.escola != null && p.escola!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      p.escola!,
                      style: FlutterFlowTheme.of(context).bodySmall.override(
                            font: GoogleFonts.inter(), color: _secondaryText),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (p.periodo != null) ...[
              const SizedBox(width: 8),
              Text(
                p.periodo!,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      font: GoogleFonts.inter(), color: _secondaryText),
              ),
            ],
            const SizedBox(width: 4),
            Icon(Icons.chevron_right_rounded, color: _secondaryText, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _avatar(PassageiroTabItem p) {
    if (p.foto != null && p.foto!.isNotEmpty) {
      return CircleAvatar(
          radius: 26, backgroundImage: NetworkImage(p.foto!));
    }
    return CircleAvatar(
      radius: 26,
      backgroundColor: _primary.withValues(alpha: 0.12),
      child: Text(
        p.iniciais,
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              font: GoogleFonts.inter(fontWeight: FontWeight.w700),
              color: _primary),
      ),
    );
  }

  Widget _buildVazio() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline_rounded,
              size: 64, color: _secondaryText.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          Text('Nenhum passageiro encontrado',
              style: FlutterFlowTheme.of(context)
                  .bodyMedium
                  .override(font: GoogleFonts.inter(), color: _secondaryText)),
        ],
      ),
    );
  }

  Widget _buildErro() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded,
              size: 48, color: Colors.red.shade300),
          const SizedBox(height: 12),
          Text('Erro ao carregar',
              style: FlutterFlowTheme.of(context).titleSmall.override(
                    font: GoogleFonts.interTight(), color: _primaryText)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _model.carregar,
            style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            child: const Text('Tentar novamente',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ── Filter sheets ───────────────────────────────────────────

  void _showFiltroPeriodo() {
    _showFilterSheet(
      titulo: 'Período',
      opcoes: _model.periodosDisponiveis,
      labelTodos: 'Todos os períodos',
      selecionado: _model.periodoFiltro,
      onConfirm: _model.setFiltroPeriodo,
    );
  }

  void _showFiltroEscola() {
    _showFilterSheet(
      titulo: 'Escola',
      opcoes: _model.escolasDisponiveis,
      labelTodos: 'Todas as escolas',
      selecionado: _model.escolaFiltro,
      onConfirm: _model.setFiltroEscola,
    );
  }

  void _showFilterSheet({
    required String titulo,
    required List<String> opcoes,
    required String labelTodos,
    required String? selecionado,
    required void Function(String?) onConfirm,
  }) {
    String? temp = selecionado;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: _bg,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2)),
              ),
              Text(titulo,
                  style: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w700),
                        color: _primaryText)),
              const SizedBox(height: 16),
              _filterOption(
                  ctx: context,
                  label: labelTodos,
                  active: temp == null,
                  onTap: () => setS(() => temp = null)),
              ...opcoes.map((o) => _filterOption(
                    ctx: context,
                    label: o,
                    active: temp == o,
                    onTap: () => setS(() => temp = o),
                  )),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      onConfirm(null);
                      Navigator.pop(ctx);
                    },
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: _primary),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: Text('Limpar',
                        style: TextStyle(
                            color: _primary, fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      onConfirm(temp);
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 14)),
                    child: const Text('Confirmar',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filterOption({
    required BuildContext ctx,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: FlutterFlowTheme.of(ctx).bodyMedium.override(
                      font: GoogleFonts.inter(
                          fontWeight:
                              active ? FontWeight.w700 : FontWeight.normal),
                      color: active ? _primaryText : _secondaryText),
              ),
            ),
            if (active) Icon(Icons.check_rounded, color: _primary, size: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _abrirDetalhe(int passageiroId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PassageiroDetalheMWidget(passageiroId: passageiroId),
      ),
    );
    _model.carregar();
  }

  Future<void> _abrirForm(int? passageiroId) async {
    await context.pushNamed(
      PassageiroFormMWidget.routeName,
      queryParameters: passageiroId != null
          ? {'passageiroId': passageiroId.toString()}
          : {},
    );
    _model.carregar();
  }
}
