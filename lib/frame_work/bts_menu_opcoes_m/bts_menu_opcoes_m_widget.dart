import '/backend/supabase/supabase.dart';
import '/colaboradores/bts_colab_editar_m/bts_colab_editar_m_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'bts_menu_opcoes_m_model.dart';
export 'bts_menu_opcoes_m_model.dart';

class BtsMenuOpcoesMWidget extends StatefulWidget {
  const BtsMenuOpcoesMWidget({super.key});

  @override
  State<BtsMenuOpcoesMWidget> createState() => _BtsMenuOpcoesMWidgetState();
}

class _BtsMenuOpcoesMWidgetState extends State<BtsMenuOpcoesMWidget> {
  late BtsMenuOpcoesMModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BtsMenuOpcoesMModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 1.0),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 48.0, 0.0, 0.0),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.0, -1.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 32.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    Navigator.pop(context);
                                  },
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowLeft,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 26.0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24.0, 0.0, 0.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Meus dados',
                                        style: FlutterFlowTheme.of(context)
                                            .titleLarge
                                            .override(
                                              font: GoogleFonts.interTight(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                          ))
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 16.0, 16.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 4.0),
                                        child: Text(
                                          'Meus Dados',
                                          style: FlutterFlowTheme.of(context)
                                              .headlineMedium
                                              .override(
                                                font: GoogleFonts.interTight(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 0.0, 8.0),
                                        child: Text(
                                          'Abaixo você pode visualizar seu perfil.',
                                          style: FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primary,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .labelMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ].divide(SizedBox(width: 6.0)),
                              ),
                            ),
                          Align(
                            alignment: AlignmentDirectional(-1.0, -1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 0.0),
                              child: FutureBuilder<List<UsuarioRow>>(
                                future: UsuarioTable().querySingleRow(
                                  queryFn: (q) => q.eqOrNull(
                                    'idUsuario',
                                    FFAppState().idUsuario,
                                  ),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50.0,
                                        height: 50.0,
                                        child: SpinKitPulse(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          size: 50.0,
                                        ),
                                      ),
                                    );
                                  }
                                  List<UsuarioRow> wrapUsuarioRowList =
                                      snapshot.data!;

                                  final wrapUsuarioRow =
                                      wrapUsuarioRowList.isNotEmpty
                                          ? wrapUsuarioRowList.first
                                          : null;

                                  return Wrap(
                                    spacing: 16.0,
                                    runSpacing: 16.0,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment:
                                        WrapCrossAlignment.start,
                                    direction: Axis.horizontal,
                                    runAlignment: WrapAlignment.center,
                                    verticalDirection: VerticalDirection.down,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxWidth: 470.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            width: 1.0,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              width: 72.0,
                                              height: 72.0,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 2.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    wrapUsuarioRow?.urlFoto !=
                                                                null &&
                                                            wrapUsuarioRow
                                                                    ?.urlFoto !=
                                                                ''
                                                        ? wrapUsuarioRow!
                                                            .urlFoto!
                                                        : 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAMAAzAMBIgACEQEDEQH/xAAcAAABBAMBAAAAAAAAAAAAAAAEAwUHCAABAgb/xABHEAABAgQBCAgCBwYFBAMBAAABAgMABAURBgcSExQhMUFRIjNSYXGBkaEyciM0QmKxwdEIFSRDU5KUsuHw8RZFgqJUY8I2/8QAFAEBAAAAAAAAAAAAAAAAAAAAAP/EABQRAQAAAAAAAAAAAAAAAAAAAAD/2gAMAwEAAhEDEQA/AJxjRMN+uO93pGjOu2+z6QCT/Wq8THEHolWnEhZvdW02jrUmu/1gOpPqE+ELw3uPKl1lpu2andsjWuO93pAZP9ePlgaDWkCaTpHb527ZCmpNd8AnTv5ngPzgyAnryhAZ+1vzu7/mONcd7vSAWn+pHzCAIMaUZlRQ9a28ZsK6k13wAkn9YTDmIFcYSwnSN/EOcIa473ekAc91K/CGnlBImXHCEG1lbN0ECTatx9YBuMPMDGSasd9++B9cd+76QDjDS/1qvmP4wtrjvd6QsmVbcRnKvdW2AAhzlOoT4RzqbX3vWEHHlS6tG3bNTzgDzAE/1w+WOdcd+75iFWUCaSVu/EDbZABRkOOpNd8ZqTXfAN0aV8Jg7UR2j6RhkU9s+kASx1SPlEdmAjNls5gSDm7LkxmvHsD1gEpzr1eMIQaGNZAdJIzuFozUR2j6QHch1P8A5QVAJc1Q6IDOvtuYzXj2B6wG6j/L8/ygKDBacJzjmlG623/e6NOSzTSCtx4IQN6lWAEBqQI0yvlhwjwdXykYRoLikLq7c0+BYtyqS7/7Doj1jy87l7paDaSo82995xaUD02wEuzn1dUNnGIkey+FxJCaCLd7/wDpHMtlyl84axQnc3/63xf3EBMDPWo+YQ7xE9Lyw4SmFJM0qdkVA3+lZz0/+lz7R7qkYppdZZ0lKnpWbHENO3UPFO8eYgH2GYbhBip1QBBQB5xvUU9o+kAGIdWerT8ogbUU9o+ka1stXbzQc02BvAHQ1zf1hULGePYHrG9BrNnSc0qG0CAC4iHCn9SfmjnUU9o+kc5+qfRpGdfbtgDoyAdePYHrGa8ewPWAOjRgXX2+yqNa82T8KoAR7rVeJjiC1SqnVZ4UAFbY1qK+2mAJk+oT4QvAaZhMsNEsElPERvX2+yqASn/rCflgQkJTnKIAAuSdwhSrTUtLyblRmn0y8uyi7i3NgSBFdsoWUicxG87JUxSpWkA2sOiuY271cbd3r3BImK8r1OoenlKIlNRnB0dID9Cg+P2vKIereKsSYvmwzPTcxMlw2RKMA5hPIIG/3j0eBslk9XkonasXJCnKF0dH6R3wB3DvicsN0Cg4ZY0dHp6GlEWW8U3cX4q3wEDUbJHimotodm5dunMK/wDkq6YHyDb62j1shkQk0hJqFYecPEMthI97xMyla2kNp2EbbmOdRX20wEZy2RfDKlpQp2dVfjpLR1N5CKA6n+Gn51g87hX4iJLSyZc6VSgQngIU15vsqgIKrOQepS6VuUqqy8xb4UPpKCfMXHtEfVjDeIcLPJfnpKalCg9CaavmX7nE7LxbVU2h0ZgQels2wl+7ypstuaNaFCykKTdKhyIttEBXnCuVusUwpZrSf3jLWtnbEujz4+cT3hfFNIxPJCZo82l4D42jsW33KTwjwmL8jVNqiFv0Qt0+cO3MSPol+I4eUQo4zXsE11C1F6n1Bo3SoHYofgpJgLgEjdDU91i/mMeQybZTJXFMsmUn0pl6s0jptg9F4D7SP04R7ZUqpw54UAFG4BgBYc5PqEeEDaivtphRMwmWGiUCSniIAyG+e67yhXX2z9hUJrQZs6RHRG6xgBIyCtRX20xmor7aYAXbzjLm2+F9Ue7HuP1jWqPdj3H6wDgx1SPCFIGRMtNpCFKsoCx2RszjFvj9jACTnXqtzgdbiWkKW6tKW0AqUpWwJA3kwU82t5RcbGclR2cIiHLjilckwnDkm5muvpz5tSTtS3wT5/lAeJymY8dxTPGRklqbo8us5g3aZXbI5ch/se2ySZLWy2zXcSsZyr58tJObk8lLHPkIY8iuC2apOCuVZq8lLK/h21J2PODj3gfjFgUzTAHxW8jAJT4CUtpG6xFh5QLc84KmP4rM0Bzs2+d7Qlqr3Y9x+sApI20x7hthvxJjKgYaRer1BppdtjSeks+CRtjwuVDKCrCyVUmkqSas8j6R0bRLJPHvUeHKIcoeH6/jSpOGUQuYWpV35t9dkpvzUfwEBMM9l0w6QptmnVNxN7Z+ahII5i6r+sEUfKxhapPBtb0xILJt/FoAB80kj1jzUlkJ0jQ1nEN3iPgYlCQDx2lQv6CGbEWRbENJllzNNfZqTKU3WhA0btht2JJIPkb90BPEo8h/QusuIdbWQUrQq4PnDyIqjgbHFTwdUUpOldkAuz8o4T0eZTf4TFnaXW5CqU9ieknw5LvoCkKAO7v74Bxttjx2KMN03FFLMjUWtwu26gdNpVtigfyj1Wts3HS39xgPVHrDoe4gKq4joNWwTX0tuOLbcbVpJWab2BwA7x+YiwWSrHTWMKRo5nMbqsqAmYb7Y4LT3HjyPlBmM8INYpojsjMNBLw6bDtxdtY3W7jxiuNJqFSwNi1L+jU1NSTpbfaOzPTxHmIC30Nc516vGMpFckatTZaoSroLMw2Fp2H0jt1pb7hW0M5J3GAGF+fCHCQH0J8YG1V7se4hdhwSyMx7oqvfnAGRkIa2z2vYxmts9r2MAvGjCenb7afWM07fbT6wDa8fpVfMY4hZxtxS1KCCQTcWEcaF3g0rzEB3PVFikUOYqM2qzEqyp1fMgC9h3xU9P7xxri7NuVztTmd17hFz+CR7CJry81fUcGy9MBIcnZgBYB2hCOkfe0eY/Z5ozbtUqFbfzQJZAYauftK2qPpb1gJhkaXLUWnSdMkkZkvLMhCRztvJ7zvhWCZpJcdzmyVC1rjbCWhc/pr9IAmnfzPAfnCWIqq1Q6HO1SY6uVaU4RzsNg8zYQpJ/RZ2k6N92ds/3viPsv8AUNBgIMNqB1qdaaVY8AFL/FAgIMp8vUca4tSytzPm6i8VOuHckb1HwAHtFmqJSZOh0xmn09oNMtC27atXFR7zEP8A7Psgh+r1aczCp2Xl0No2bgtRv/lETjonf6a/SAUlPrCYcSLiG+WQtDoUtJSBxOyDdM320+sBC2XfBTSJb/qilshDiFBM8lI2KB2By3jsPjDZkHxC4mYmcPzC7oWkvyw7JHxj0228YmvEMqxVKFPyDhSpD8utGb4gxVfJ7NrkcdUJxIOcZxtpXOyzmK9lGAtGo3Sdp3Q9w0Bh03BRa8OWnb7afWAUIiCcvuGhdvEkq2M5KtBNkcR9hR/y+YictO3/AFEesMOIaWKzSZ+nutlTU00tIPK42EedoCKMguIVLTN4efX8AMxLXPDZnp9wfWJzk/q6PCKj4TnXMOY0kXnQQZaa0TwHEXKVD3MW2l3EJZSCpI8TwgCYb57rh4QZpkH7afWBJsKccBbSVC28QAkZHehd/pr9I3oXf6a/SATjSvhMdWPIxog23GAdmOpR8ojswmwRokbeEKEjmICuv7Q07pMVykmlWxiWCiO9R/0j3WRyREngSTWR05ha3SbbwTYRF2XNeflCm/utNp9omzArIZwbRm0g7JVHDntgPWSB+hPzGCoFkdjO3Z0oJuOcAFUv5fn+URfl1lVPYJQ4gbJaeaWr5SlafxUIlGo7cy23f+UMGJqO3XqFP0t5IOstFKVEfCvelXkoA+UBFv7N8223WavKKV9I9LtrSk8c1Rv/AJhE/RUHDFXnMF4rl51bS0uybpbmGL2zkblp9N3fYxbKl1GVqkixOyLodl30BSFjiP1gFZz6uuGzduhznDeXXaG0i+wg7YASqTTclTZqaeVZDLK1qJ4AC8VnyeS709j+gpb2r/eDTyvBKs9XskxKOW3FbcpS/wDp2UXeZmrGaKT1bYIObs4qO/uBhp/Z9w6qZrT9ffbsxJoLUupQ+JxWxRHgm484CwAhmG4Q8ApA3iGcA2Gw+kBsGHVrqUX7IhqseRh0aI0KR90QFVMrMj+68f1RtvopW4Hk92cLxYXDk9+8sPUycBvpZVtR9LRC/wC0E0EY4acA6yUQT7iJRyXqU7gOkkg9FnNHkYD1EOFP6k/NAFjyO6D5DYzY7NsAVGRq45xlxzgMzRyHpGikchHUaMA1PE6VYBt0t0cXPOOnutV8xjgjmYCuWWtBTjyZUr7bLah6RYTJ64l/BFFcBCgZRAuNu7ZEKZf5AtYhp88B0ZiVzb96Sf1iTsh9QE7gCUb+3KrWyocrG4/GA9fPbHhbswPc84Jnz9OPlgWAMp+3SX5Df5wZ0bX2Wjz9UrslhykTlUqLgQwylOy+1SjcBI7zsiu+L8pGIMTTStHMuycnf6OWlllOzhnEbSYCRMsmT41FxeIaChC5wD+Kl0qGc6B9pI4kcuURhhDHNXwi4pEooOyqlErlHz0b93ZMACh4pcs6mkVpaSLhQl3j72hA4YxAf+w1T/BufpATHIZcqGEIXOUmotugdJDRQ4n1JH4Q1Ymy6TE0y5L4ep+qBQ+sTBCljwSNgPmYjH/pfEJ/7DVf8G5+kbGFcR3/AP5+rf4Jz9IBxwxh2q43rasxxSgpWfNzjxuEA8SeJNjYRY/D9Kk6HSZenU1ITLsp2WNyo8VHvJisjeHMTtAhqh1lF9+bKOj8o502I8PzDS3DVKc6TdOkz287yO+AtaVE7CbiHmw5D0iGMmWUlVdmE0euqQJ1QOgfAzQ9YbUnkrZEzjdAZYch6Q1Ok6RW0/EeMOphpeH0qxxzjsgK+Zd3g7jJpsEXblEA+dzE0ZI28zJ7RwftM39zFfsqk8KjjypKaHRQtLKB8oAiy+CZMU/ClKk7WLMsgEeUA9Zo5D0gGe2Oi3KHCG+e67ygBrnnGXPOMjUAppnO2r1jRdXwcX6xxGWNoBzaaQptJUlJJFySI60DY3IR6RtjY0i/KO4CJcv9JM3hlufbBvT303AH2F9H8bR5bIJWtBPT9IWvNEygPt7bXUnYoelombEEgxVJSdp82i7Ey0ppfcCLX8t8VXaVUcHYrzvhnKbM7Qdy7Hd4KHsYC3UogOt3cGcq9rqG2F9A32E/2w3YaqcvV6PLVCTVnMzKQ4juB4eR2eUOt4CCf2jqiRN0ekoOa0lC5hxA4qJzUk+ACvUwvkNw1KpppxHMIS5NOrU2wVC+iSk2JHeSN8eWy/TZmMoC2tlpeVabHur/APUSxkylhKYEoyLWKmdJ5qN/zgPYypLzpDpzwBeyttjBmhR2E+kByHXH5YcIAeYSG2ipKQkjikWMAF57+osecOE5tl1DnDZ5QCra1qcSlbiiknaCYVq1JkqvIPSFQlm35Z0WUhQ9xyI5wgz1qPmEOqtxtAU9xLIO4WxZNyUs8sOyEyFMOW2i1lJPjui0tOqCp+QlpxC1BMwyh0AHdnAH84r/AJdpbV8oMysDY+y25fmbW/IRMeTmZ1vAlFd3lMsEKPLNJT+UB6bTOdswnXahL0agTlUmEptLy5dJttJA2e8ZuiJ/2gMUHQymGZR05xAfnM08PsJPufIQEa4QkHMTY1kJdd86am9K8QNwuVKPsYtVMLU28pKFFIFrAbrRD/7O+GyNdxHMI5y0rflvWoew9Yl+b+sLgONM4ftq8jBcqA82VOWUQbbRAA3iHCn9Ur5oBXQN9hPpGaBvsJ9IVjIAfU2Owf7jGamx2PcwvGQDcuYdbUUJVYA2GyOdae7fsI4f61XzGOIA9plDzYccF1njcxEOXfBZelk4kpzZK2UhE2lPFHBXlxiYpTqEeEdPtIeZW06hK21pKVpULhQO8QFeMjGOv3NNCgz7+ZJTKrsLVazTh4beB/GJ5M08DbP48hFb8qmAXsJVRUzJIUukTCiWlbyyT9hX5HlHrMluUttSWaLiV/NcSQiXm3DsUNlkLPPkYDwOVObVO49rDijcIezL880WizmHaczLUGnMkbESyBy4f6xVadJqmN3SkZ+nqNt97jPtFvmWw20hA3JSE28BADPoEs2Fs9E3tzhDWnu37CCp/qR8whvgCWnVvuBt1V0nhBWqMnej3MBSf1hMOcAOuWabSVoTZQGw3MCGae7fsIcHupX4Q1cBAQd+0G2TXaZMq+J2XUN2/NUP1iQshq0TuT+WC07WXnGt/ff848p+0FLXplJmgNqHlt35Ai8JZH8ZU3C+CKm7VXrBqZuyyPjdUU7kiAk3HGIKZhGiO1CZALp6EuyFbXF8rcucVqpknUcb4qDanFOTc66VvOnaEJ4q8AIWxRiCq46xCl11DjjritHKyjdyGxfYAPxMTfk2wUjCNLKpoJXVZmxmF/0x2EnkL7eZgPVUaVbo1LlabI9CXlmwhIsLm3E/jDu0yiYQlx0XUeN7Q3w5ynUJ8IDWpsdg/wBxhB9SpdeYyc1Nr84OgCf64eEBxrT3b9hGtae7fsIRjIArXXOSfQxhnXOSfQwLaNHcYA9Mqh0Bargq27I3qTfNULs9Uj5RHcACt9TCi2gCyd19sc64vkPQxxOdeqEbQCs5T5WtST0vUG0usPJKHGyNhEV5ykZL5/C7rk/Tgubo5N88bVsdyhy7/XvsjIdSfmghaUrSpKkhSVCxBFwRAU0w1OsUuvyE/NJUtiXfS4tKd5APCLT4fxlS8RM6SkzbLyki62r2cR4p3+e6PFY9yQUypLVOUEpp02q5LVvoVnZw+z5RDVYwziHCc4l2dl5iWzD9HNsKOaO8LG7ztAWxQszatE4M0DbshXUm+aorRh/K5iikZqZh9uoNDYdZTddvnH53j3Ehl8lSkfvKivIVxLDoUPe0BLqmUy6S6m5I5wnrq9mxMR05luwy61mqZnkE8C3DbNZaaEhP0EjPOm+zYB+JgJX1pTnQIHS2co6clmGkKW65mNpFypRAAHjEC1PLdUF5yaRS2Jc/ZW+ouEeQt+MeIreKMSYrfDM/PTU2pauhKtg5pO8WQnf6QEiZZ8XYeq9Lbo9JmTOTDb4cU+2btJ33GdxJ7oiel0ucq883I0yWXMTLpslCE+55DviQsIZG63VVoerR/dkobXSek8R3Dh5xMOHMOUrDcmJekSoaBAz3Ttcc71KgGDJrgGWwggTs3o5mrLRZTluiz91P68YkRMohwBaioqIBgEQ6s9Wn5RAIai3zVCa3lS6i2gAgbrwfaGuc69XjAKa652QY7QgTY0i9nCwgIDbDhT9rJ+aAzUm+aozUm+aoKjIAHUfv+0YZH7/tB0aMAHrQasi183Ze8Zrw7HvAr/Wq8THEAaWNYOlC7BXC0a1H7/tC8n1CfCF4AIOap9HbO43jNeHY94Tn/rCflgYboAw/xpFuhmcfH/iNLp4WkpWQpJ3hSbgx1Tv5ngPzg2A8FXMmGEagVPzNKQ06reuUUWtvOwOb7R5CfyJUZw50jVZ1lO7NcQldvPZEwz/Uj5oAgIfGQkuO5rddTY7bln/WC2cgLdxp6+rN+5Li/uYluT+sJhzEBF1PyI4Xkjnzy5yfzRcpW7o0n+2x949jRqVRaE0G6TSJaVFviaQM4+Kt58zD8/1K/CGjgIA3XUjapsgeMaEibbV+0BndDyIALUT2/aNibDfQzPh2b+UGGGl7rF/MYArXh2PeNaDWTpQrNCuG+A4c5P6ujwgENRPbHpGw5qgzCm99t4Nhvn+uHhAd68Ox7xmvDse8BRkA464z97+2Na4zyV6QBeNE7DAErlXXFFac2xNxeNak99z1g5jqkfKI7gBW30MJ0bl84cheOtdZ+9/bAs316vGEIAt1JmVaRo9G1tuyOdTe4FHmTC8h1P8A5QTaADaGqlWlt09xHd/zCmus/e/thOo/y/P8oDvAGOrEyC21vBvthLU3uaPUx1Idcflg+0AAhlcurSOWzRyhfXGt5v6R1OD+HXDbAHqmm3ElKc65Ft0DmTd4FFu8wmyfpUfMIdbQDdqTpFjmesE66z97+2CIZgdggHEzrP3v7YHVLOOqK0kAK74Hh1ZH0KB90QAOpvc0ephdDyGEhty908oKtDZN9erxgC9ca+96Qi6kzSs9m1gLXVsgW8HyHUn5oAcyb3NHrGam9zb9TDjaMtAf/9k=',
                                                    width: 44.0,
                                                    height: 44.0,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Image.asset(
                                                      'assets/images/error_image.png',
                                                      width: 44.0,
                                                      height: 44.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  4.0,
                                                                  0.0,
                                                                  4.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            valueOrDefault<
                                                                String>(
                                                              wrapUsuarioRow
                                                                  ?.nomeUsuario,
                                                              '-',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .interTight(
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  fontSize:
                                                                      18.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontWeight,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineSmall
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        4.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                wrapUsuarioRow
                                                                    ?.whatsappUsuario,
                                                                '-',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              height: 2.0,
                                              thickness: 1.0,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        constraints: BoxConstraints(
                                          maxWidth: 570.0,
                                        ),
                                        decoration: BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 6.0, 16.0, 6.0),
                                                child: Text(
                                                  'Outras opções',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts.inter(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .fontStyle,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 1.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 1.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  BtsColabEditarMWidget(
                                                                idUsuario:
                                                                    wrapUsuarioRow
                                                                        ?.idUsuario,
                                                                tabindex: 2,
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.4,
                                                        height: 120.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              offset: Offset(
                                                                0.0,
                                                                1.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .password_sharp,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Trocar senha',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 1.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        await showModalBottomSheet(
                                                          isScrollControlled:
                                                              true,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          enableDrag: false,
                                                          context: context,
                                                          builder: (context) {
                                                            return Padding(
                                                              padding: MediaQuery
                                                                  .viewInsetsOf(
                                                                      context),
                                                              child:
                                                                  BtsColabEditarMWidget(
                                                                idUsuario:
                                                                    wrapUsuarioRow
                                                                        ?.idUsuario,
                                                              ),
                                                            );
                                                          },
                                                        ).then((value) =>
                                                            safeSetState(
                                                                () {}));
                                                      },
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.4,
                                                        height: 120.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 0.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .alternate,
                                                              offset: Offset(
                                                                0.0,
                                                                1.0,
                                                              ),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      24.0),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Icon(
                                                                    FFIcons
                                                                        .kpersonFill,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    size: 24.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                  'Editar perfil',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .inter(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        fontSize:
                                                                            12.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 1.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      height: 120.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 0.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            offset: Offset(
                                                              0.0,
                                                              1.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  FFIcons
                                                                      .ktagsFill,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                'Benefícios ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 1.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      height: 120.0,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 0.0,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            offset: Offset(
                                                              0.0,
                                                              1.0,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(24.0),
                                                        shape:
                                                            BoxShape.rectangle,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    16.0,
                                                                    0.0,
                                                                    16.0,
                                                                    0.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 1,
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Icon(
                                                                  FFIcons
                                                                      .kdocumentText,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  size: 24.0,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                'Documentos',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .inter(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      fontSize:
                                                                          12.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional(0.0, 1.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(LoginWidget.routeName);
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 36.0, 0.0, 12.0),
                                  child: Text(
                                    'Sair do app',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ].addToEnd(SizedBox(height: 72.0)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
