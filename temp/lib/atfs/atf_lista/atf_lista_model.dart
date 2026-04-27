import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class AtfListaModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for ListView widget.

  PagingController<int, AtfRow>? listViewPagingController;
  Future<List<AtfRow>> Function(int)? listViewPagingQuery;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    listViewPagingController?.dispose();
  }

  /// Additional helper methods.
  PagingController<int, AtfRow> setListViewController(
    Future<List<AtfRow>> Function(int) query,
  ) {
    listViewPagingController ??= _createListViewController(query);
    if (listViewPagingQuery != query) {
      listViewPagingQuery = query;
      listViewPagingController?.refresh();
    }
    return listViewPagingController!;
  }

  PagingController<int, AtfRow> _createListViewController(
    Future<List<AtfRow>> Function(int) query,
  ) {
    final controller = PagingController<int, AtfRow>(firstPageKey: 0);
    return controller
      ..addPageRequestListener(
        (nextPageMarker) => query(nextPageMarker).then((page) {
          final isLastPage = page.length < 50;
          if (isLastPage) {
            controller.appendLastPage(page);
          } else {
            final nextPageMarker = page.last.id;
            controller.appendPage(page, nextPageMarker);
          }
        }).onError((error, _) {
          controller.error = error;
        }),
      );
  }
}
