import 'dart:math';
import 'dart:typed_data';

import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Definição de um tipo de documento esperado
class TipoDocumento {
  final String tipo;
  final String label;
  final bool obrigatorio;

  const TipoDocumento({
    required this.tipo,
    required this.label,
    this.obrigatorio = false,
  });
}

/// Tipos de documentos para USUARIO / TRANSPORTADOR
const List<TipoDocumento> tiposDocumentosUsuario = [
  TipoDocumento(tipo: 'CNH', label: 'CNH', obrigatorio: true),
  TipoDocumento(tipo: 'RG', label: 'RG'),
  TipoDocumento(tipo: 'FOTO', label: 'Foto 3x4'),
  TipoDocumento(tipo: 'CRLV', label: 'CRLV do Veículo'),
  TipoDocumento(
      tipo: 'AUTORIZACAO_TRANSPORTE', label: 'Autorização de Transporte'),
  TipoDocumento(
      tipo: 'PERMISSAO_TRANSPORTE',
      label: 'Permissão para Transporte Escolar'),
  TipoDocumento(tipo: 'EXAME_TOXICOLOGICO', label: 'Exame Toxicológico'),
  TipoDocumento(tipo: 'OUTROS', label: 'Outros'),
];

const String _bucketName = 'documentos';

const int _maxFileSize = 10 * 1024 * 1024; // 10 MB

class DocumentosUsuarioWidget extends StatefulWidget {
  const DocumentosUsuarioWidget({
    super.key,
    required this.idUsuario,
    this.nomeUsuario,
  });

  final int? idUsuario;
  final String? nomeUsuario;

  @override
  State<DocumentosUsuarioWidget> createState() =>
      _DocumentosUsuarioWidgetState();
}

class _DocumentosUsuarioWidgetState extends State<DocumentosUsuarioWidget> {
  List<DocumentoRow> _documentos = [];
  bool _loading = true;
  String? _uploadingTipo;

  @override
  void initState() {
    super.initState();
    _fetchDocumentos();
  }

  // ---------- SUPABASE QUERIES ----------

  Future<void> _fetchDocumentos() async {
    if (widget.idUsuario == null) return;
    setState(() {
      _loading = true;
    });

    try {
      final rows = await DocumentoTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('categoria', 'TRANSPORTADOR')
            .eqOrNull('idusuario', widget.idUsuario)
            .eqOrNull('ativo', true)
            .order('tipo_documento')
            .order('dtcadastro'),
      );
      setState(() {
        _documentos = rows;
        _loading = false;
      });
    } catch (e) {
      debugPrint('[DocumentosUsuario] Erro ao buscar: $e');
      setState(() {
        _loading = false;
      });
    }
  }

  DocumentoRow? _getDocumentoPorTipo(String tipo) {
    try {
      return _documentos.firstWhere((d) => d.tipoDocumento == tipo);
    } catch (_) {
      return null;
    }
  }

  // ---------- UPLOAD ----------

  /// Exibe bottom sheet para escolher a origem: Câmera, Galeria ou Arquivo
  Future<void> _handleUpload(String tipoDocumento) async {
    if (widget.idUsuario == null) return;

    final theme = FlutterFlowTheme.of(context);

    final fonte = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: theme.primaryBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Escolha a origem',
                    style: theme.titleSmall.override(
                      font: GoogleFonts.interTight(fontWeight: FontWeight.w600),
                      letterSpacing: 0,
                    ),
                  ),
                ),
                if (!kIsWeb)
                  ListTile(
                    leading: Icon(Icons.camera_alt, color: theme.primary),
                    title: Text('Câmera', style: theme.bodyMedium),
                    onTap: () => Navigator.pop(ctx, 'camera'),
                  ),
                ListTile(
                  leading: Icon(Icons.photo_library, color: theme.primary),
                  title: Text('Galeria de fotos', style: theme.bodyMedium),
                  onTap: () => Navigator.pop(ctx, 'galeria'),
                ),
                ListTile(
                  leading: Icon(Icons.attach_file, color: theme.primary),
                  title: Text('Arquivo (PDF, JPG, PNG)', style: theme.bodyMedium),
                  onTap: () => Navigator.pop(ctx, 'arquivo'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (fonte == null) return;

    String? fileName;
    Uint8List? fileBytes;
    String ext;
    String mimeType;

    if (fonte == 'camera' || fonte == 'galeria') {
      // Usar ImagePicker para câmera ou galeria
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: fonte == 'camera' ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1920,
      );
      if (image == null) return;

      fileBytes = await image.readAsBytes();
      fileName = image.name;
      final imgExt = image.path.split('.').last.toLowerCase();
      ext = (imgExt == 'jpg' || imgExt == 'jpeg' || imgExt == 'png') ? imgExt : 'jpg';
      mimeType = 'image/$ext';
    } else {
      // FilePicker para PDF / JPG / PNG
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.bytes == null) {
        _showSnack('Erro ao ler arquivo');
        return;
      }
      fileBytes = file.bytes!;
      fileName = file.name;
      ext = file.extension?.toLowerCase() ?? 'pdf';
      mimeType = ext == 'pdf' ? 'application/pdf' : 'image/$ext';
    }

    // Validar tamanho
    if (fileBytes.length > _maxFileSize) {
      _showSnack('Arquivo muito grande. Máximo: 10MB');
      return;
    }

    setState(() {
      _uploadingTipo = tipoDocumento;
    });

    try {
      final uuid =
          '${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(999999)}';
      final caminhoStorage =
          'transportador/${widget.idUsuario}/$tipoDocumento/$uuid.$ext';

      // 1) Upload to Supabase Storage
      await SupaFlow.client.storage.from(_bucketName).uploadBinary(
            caminhoStorage,
            fileBytes,
            fileOptions: FileOptions(contentType: mimeType),
          );

      // 2) Deactivate previous documents of the same type
      await SupaFlow.client
          .from('documento')
          .update({'ativo': false, 'dtatualizacao': DateTime.now().toIso8601String()})
          .eq('categoria', 'TRANSPORTADOR')
          .eq('idusuario', widget.idUsuario!)
          .eq('tipo_documento', tipoDocumento)
          .eq('ativo', true);

      // 3) Insert new document row
      await SupaFlow.client.from('documento').insert({
        'idusuario': widget.idUsuario,
        'categoria': 'TRANSPORTADOR',
        'tipo_documento': tipoDocumento,
        'nome_arquivo': fileName,
        'tamanho_bytes': fileBytes.length,
        'mime_type': mimeType,
        'bucket': _bucketName,
        'caminho_storage': caminhoStorage,
        'ativo': true,
      });

      // 4) Refresh list
      await _fetchDocumentos();
      _showSnack('Documento enviado com sucesso!', isError: false);
    } catch (e) {
      debugPrint('[DocumentosUsuario] Erro no upload: $e');
      _showSnack('Erro ao enviar arquivo');
    } finally {
      setState(() => _uploadingTipo = null);
    }
  }

  // ---------- VIEW ----------

  Future<void> _handleVisualizar(DocumentoRow doc) async {
    try {
      final signedUrl = await SupaFlow.client.storage
          .from(doc.bucket)
          .createSignedUrl(doc.caminhoStorage, 300);

      final uri = Uri.parse(signedUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnack('Não foi possível abrir o documento');
      }
    } catch (e) {
      debugPrint('[DocumentosUsuario] Erro ao visualizar: $e');
      _showSnack('Erro ao abrir documento');
    }
  }

  // ---------- HELPERS ----------

  void _showSnack(String msg, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red.shade700 : Colors.green.shade700,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String _formatBytes(int? bytes) {
    if (bytes == null || bytes == 0) return '';
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String _formatDate(DateTime dt) {
    return DateFormat('dd/MM/yyyy').format(dt);
  }

  // ---------- BUILD ----------

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: theme.primaryBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
              color: theme.alternate,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: theme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.description_outlined,
                    color: theme.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Documentos',
                        style: theme.titleMedium.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                          ),
                          letterSpacing: 0,
                        ),
                      ),
                      if (widget.nomeUsuario != null)
                        Text(
                          widget.nomeUsuario!.toUpperCase(),
                          style: theme.labelSmall.override(
                            font: GoogleFonts.inter(),
                            color: theme.secondaryText,
                            letterSpacing: 0,
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: theme.secondaryText),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: theme.alternate),

          // Content
          Flexible(
            child: _loading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: SpinKitPulse(
                        color: theme.primary,
                        size: 40,
                      ),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    itemCount: tiposDocumentosUsuario.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final tipoDoc = tiposDocumentosUsuario[index];
                      final doc = _getDocumentoPorTipo(tipoDoc.tipo);
                      final isUploading = _uploadingTipo == tipoDoc.tipo;

                      return _buildDocCard(
                        tipoDoc: tipoDoc,
                        documento: doc,
                        isUploading: isUploading,
                      );
                    },
                  ),
          ),

          // Footer
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: theme.primaryBackground,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Fechar',
                    style: theme.bodyMedium.override(
                      font: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      color: theme.primaryBackground,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocCard({
    required TipoDocumento tipoDoc,
    DocumentoRow? documento,
    required bool isUploading,
  }) {
    final theme = FlutterFlowTheme.of(context);
    final hasFile = documento != null;

    return Container(
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: tipoDoc.obrigatorio && !hasFile
              ? Colors.orange.shade300
              : theme.alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: hasFile
                    ? theme.primary.withValues(alpha: 0.1)
                    : theme.alternate.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                hasFile ? Icons.description : Icons.insert_drive_file_outlined,
                color: hasFile ? theme.primary : theme.secondaryText,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          tipoDoc.label,
                          style: theme.bodyMedium.override(
                            font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600),
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      if (tipoDoc.obrigatorio)
                        Text(
                          ' *',
                          style: theme.bodyMedium.override(
                            font: GoogleFonts.inter(),
                            color: Colors.red,
                            letterSpacing: 0,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  if (hasFile)
                    Text(
                      '${documento.nomeArquivo.length > 30 ? '${documento.nomeArquivo.substring(0, 27)}...' : documento.nomeArquivo}'
                      '${documento.tamanhoBytes != null ? ' • ${_formatBytes(documento.tamanhoBytes)}' : ''}'
                      ' • ${_formatDate(documento.dtcadastro)}',
                      style: theme.labelSmall.override(
                        font: GoogleFonts.inter(),
                        color: theme.secondaryText,
                        letterSpacing: 0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  else
                    Text(
                      'Nenhum arquivo anexado',
                      style: theme.labelSmall.override(
                        font: GoogleFonts.inter(),
                        color: theme.secondaryText,
                        letterSpacing: 0,
                      ),
                    ),
                ],
              ),
            ),

            // Actions
            if (isUploading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else if (hasFile)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // View
                  IconButton(
                    icon: Icon(Icons.visibility_outlined,
                        color: theme.primary, size: 20),
                    tooltip: 'Visualizar',
                    onPressed: () => _handleVisualizar(documento),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  // Replace
                  IconButton(
                    icon: Icon(Icons.refresh,
                        color: theme.secondaryText, size: 20),
                    tooltip: 'Substituir',
                    onPressed: () => _handleUpload(tipoDoc.tipo),
                    constraints: const BoxConstraints(
                      minWidth: 36,
                      minHeight: 36,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              )
            else
              // Upload
              IconButton(
                icon: Icon(Icons.upload_file, color: theme.primary, size: 22),
                tooltip: 'Anexar documento',
                onPressed: () => _handleUpload(tipoDoc.tipo),
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                padding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
}
