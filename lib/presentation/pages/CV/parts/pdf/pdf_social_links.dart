part of '../../cv_page.dart';

pw.Widget buildPdfSocialLinks(List<Map<String, dynamic>> socials) {
  return pw.Row(
    children: socials.map((social) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(right: 8),
        child: pw.UrlLink(
          destination: social['url'],
          child: pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(color: PdfColors.grey300),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
            ),
            child: PDFIconHandler.socialIcon(
              social['icon'],
              size: 20,
            ),
          ),
        ),
      );
    }).toList(),
  );
}
