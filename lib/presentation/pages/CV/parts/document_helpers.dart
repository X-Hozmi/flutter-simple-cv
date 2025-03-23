part of '../cv_page.dart';

Future<void> printCV(GlobalKey printKey, CVState state) async {
  await Printing.layoutPdf(
    onLayout: (format) async {
      return await generatePDF(format, printKey, state);
    },
  );
}

Future<Uint8List> generatePDF(
    PdfPageFormat format, GlobalKey printKey, CVState state) async {
  await PDFIconHandler.initialize();

  final pdf = pw.Document();
  final font = await PdfGoogleFonts.robotoRegular();
  final boldFont = await PdfGoogleFonts.robotoBold();

  pdf.addPage(
    pw.Page(
      pageFormat: format,
      margin: const pw.EdgeInsets.all(40),
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            buildPdfHeader(state, font, boldFont),
            pw.SizedBox(height: 20),
            buildPdfAboutSection(state, font, boldFont),
            pw.SizedBox(height: 20),
            buildPdfExperienceSection(state, font, boldFont),
            pw.SizedBox(height: 20),
            buildPdfEducationSection(state, font, boldFont),
          ],
        );
      },
    ),
  );

  return pdf.save();
}

Future<void> downloadPDF(GlobalKey printKey, CVState state) async {
  final bytes = await generatePDF(PdfPageFormat.a4, printKey, state);
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'CV_${DateTime.now().millisecondsSinceEpoch}.pdf';

  html.document.body!.children.add(anchor);
  anchor.click();
  html.document.body!.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}

Future<void> previewPDF(GlobalKey printKey, CVState state) async {
  final bytes = await generatePDF(PdfPageFormat.a4, printKey, state);
  final blob = html.Blob([bytes], 'application/pdf');
  final url = html.Url.createObjectUrlFromBlob(blob);

  html.window.open(url, '_blank');
}

Future<Uint8List> capturePng(GlobalKey printKey) async {
  try {
    RenderRepaintBoundary boundary =
        printKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  } catch (e) {
    log(e.toString());
    return Uint8List(0);
  }
}

Future<void> downloadImage(GlobalKey printKey, String format) async {
  final image = await capturePng(printKey);
  final blob = html.Blob([image], 'image/$format');
  final url = html.Url.createObjectUrlFromBlob(blob);
  final anchor = html.document.createElement('a') as html.AnchorElement
    ..href = url
    ..style.display = 'none'
    ..download = 'CV_${DateTime.now().millisecondsSinceEpoch}.$format';

  html.document.body!.children.add(anchor);
  anchor.click();
  html.document.body!.children.remove(anchor);
  html.Url.revokeObjectUrl(url);
}
