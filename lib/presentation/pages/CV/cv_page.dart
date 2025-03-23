import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cv_page/presentation/bloc/cv_bloc.dart';
import 'package:flutter_cv_page/utils/pdf_icon_handler.dart';
import 'package:flutter_cv_page/utils/state_enum.dart';
import 'package:flutter_cv_page/utils/url_launch.dart';
import 'package:flutter_cv_page/widgets/cubit/hover_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

part 'parts/about_section.dart';
part 'parts/compentencies_section.dart';
part 'parts/document_helpers.dart';
part 'parts/educations_section.dart';
part 'parts/experiences_section.dart';
part 'parts/header.dart';
part 'parts/info_rows.dart';
part 'parts/pdf/pdf_header.dart';
part 'parts/pdf/pdf_about_section.dart';
part 'parts/pdf/pdf_experiences_section.dart';
part 'parts/pdf/pdf_educations_section.dart';
part 'parts/pdf/pdf_social_links.dart';
part 'parts/skill_chips.dart';
part 'parts/social_links.dart';
part 'parts/sticky_action_buttons.dart';

class CVPage extends StatefulWidget {
  const CVPage({super.key});

  @override
  State<CVPage> createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  final GlobalKey _printKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<CVBloc>().add(const GetProfileEvent());
    context.read<CVBloc>().add(const GetSocialsEvent());
    context.read<CVBloc>().add(const GetWorkExperiencesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: BlocBuilder<CVBloc, CVState>(
        builder: (context, state) {
          if (state.state == RequestState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == RequestState.loaded) {
            return Stack(
              children: [
                Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: SizedBox(
                        width: 800,
                        // width: 595.28,
                        child: RepaintBoundary(
                          key: _printKey,
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildHeader(context, state),
                                  const SizedBox(height: 32),
                                  InkWell(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () => urlLauncher(Uri.parse(state
                                        .profileEntity!.profile['linkedin'])),
                                    child: Column(
                                      children: [
                                        buildAboutSection(context, state),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  buildExperienceSection(context, state),
                                  const SizedBox(height: 32),
                                  buildEducationSection(context, state),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: StickyActionButtons(
                    onPrint: () => printCV(_printKey, state),
                    onDownloadPDF: () => previewPDF(_printKey, state),
                    onDownloadPNG: () => downloadImage(_printKey, 'png'),
                    onDownloadJPG: () => downloadImage(_printKey, 'jpg'),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
