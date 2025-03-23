part of '../../cv_page.dart';

pw.Widget buildPdfExperienceSection(
    CVState state, pw.Font font, pw.Font boldFont) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Experiences',
        style: pw.TextStyle(
          font: boldFont,
          fontSize: 18,
        ),
      ),
      pw.Divider(thickness: 1.5),
      ...state.workExperiences.map((experience) {
        final startDate = DateTime.parse(experience['start']);
        final endDate = experience['end'] != null
            ? DateTime.parse(experience['end'])
            : DateTime.now();

        final difference = endDate.difference(startDate);
        final years = difference.inDays ~/ 365;
        final months = (difference.inDays % 365) ~/ 30;

        String durationText = '';
        if (years > 0) {
          durationText += '$years Year${years > 1 ? 's' : ''}';
        }
        if (months > 0) {
          durationText += durationText.isNotEmpty ? ' ' : '';
          durationText += '$months Month${months > 1 ? 's' : ''}';
        }

        final formattedStartDate = DateFormat('MMM yyyy').format(startDate);
        final formattedEndDate = experience['end'] != null
            ? DateFormat('MMM yyyy').format(endDate)
            : 'Present';
        final period = '$formattedStartDate - $formattedEndDate';

        return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 16.0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: experience['url'] != null
                        ? pw.UrlLink(
                            destination: experience['url'],
                            child: pw.Text(
                              experience['company'],
                              style: pw.TextStyle(
                                font: boldFont,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : pw.Text(
                            experience['company'],
                            style: pw.TextStyle(
                              font: boldFont,
                              fontSize: 16,
                            ),
                          ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        period,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: 12,
                          fontStyle: pw.FontStyle.italic,
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text(
                        durationText,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: 10,
                          color: PdfColors.grey700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              pw.Text(
                experience['role'],
                style: pw.TextStyle(
                  font: boldFont,
                  fontSize: 14,
                ),
              ),
              if (experience['responsibilites'] != null) ...[
                pw.SizedBox(height: 12),
                ...experience['responsibilites']
                    .map<pw.Widget>((responsibility) {
                  return pw.Padding(
                    padding: const pw.EdgeInsets.only(left: 16, bottom: 4),
                    child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('- '),
                        pw.Expanded(
                          child: pw.Text(
                            responsibility,
                            style: pw.TextStyle(
                              font: font,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
              if (experience['technologies'] != null) ...[
                pw.SizedBox(height: 12),
                pw.Wrap(
                  spacing: 8,
                  children: experience['technologies']
                      .map<pw.Widget>((tech) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: pw.BoxDecoration(
                              color: PdfColors.grey100,
                              borderRadius: const pw.BorderRadius.all(
                                  pw.Radius.circular(4)),
                              border: pw.Border.all(color: PdfColors.grey300),
                            ),
                            child: pw.Text(
                              tech,
                              style: pw.TextStyle(
                                font: font,
                                fontSize: 10,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        );
      }).toList(),
    ],
  );
}
