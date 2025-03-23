part of '../../cv_page.dart';

pw.Widget buildPdfEducationSection(
    CVState state, pw.Font font, pw.Font boldFont) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'Educations',
        style: pw.TextStyle(
          font: boldFont,
          fontSize: 18,
        ),
      ),
      pw.Divider(thickness: 1.5),
      ...state.profileEntity!.educations.map((education) {
        final startDate = DateTime.parse(education['start']);
        final endDate = education['end'] != null
            ? DateTime.parse(education['end'])
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
        final formattedEndDate = education['end'] != null
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
                    child: education['url'] != null
                        ? pw.UrlLink(
                            destination: education['url'],
                            child: pw.Text(
                              education['university'],
                              style: pw.TextStyle(
                                font: boldFont,
                                fontSize: 16,
                              ),
                            ),
                          )
                        : pw.Text(
                            education['university'],
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
              // Build degree and majors
              buildPdfDegreeAndMajors(education, font, boldFont),
            ],
          ),
        );
      }).toList(),
    ],
  );
}

// Helper for building degree and majors text in PDF
pw.Widget buildPdfDegreeAndMajors(
    Map<String, dynamic> education, pw.Font font, pw.Font boldFont) {
  final textParts = <String>[];
  textParts.add('${education['degree']} of');

  for (int i = 0; i < education['majors'].length; i++) {
    final major = education['majors'][i];
    final isLast = i == education['majors'].length - 1;
    textParts.add(isLast ? major : "$major.");
  }

  return pw.Text(
    textParts.join(' '),
    style: pw.TextStyle(
      font: boldFont,
      fontSize: 14,
    ),
  );
}
