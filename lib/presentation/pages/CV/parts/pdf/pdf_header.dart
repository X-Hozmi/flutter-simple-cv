part of '../../cv_page.dart';

pw.Widget buildPdfHeader(CVState state, pw.Font font, pw.Font boldFont) {
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Expanded(
        flex: 3,
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              state.profileEntity!.profile['name'],
              style: pw.TextStyle(
                font: boldFont,
                fontSize: 24,
              ),
            ),
            pw.SizedBox(height: 8),
            pw.Text(
              state.profileEntity!.profile['role'],
              style: pw.TextStyle(
                font: font,
                fontSize: 18,
              ),
            ),
            pw.SizedBox(height: 16),
            pw.UrlLink(
              destination:
                  'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(state.profileEntity!.profile['location'])}',
              child: pw.Row(
                children: [
                  PDFIconHandler.socialIcon(
                    'location-dot',
                    size: 20,
                  ),
                  pw.SizedBox(width: 5),
                  pw.Text(
                    state.profileEntity!.profile['location'],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 16),
            buildPdfSocialLinks(state.socials),
          ],
        ),
      ),
    ],
  );
}
