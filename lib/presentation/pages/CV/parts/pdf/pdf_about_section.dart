part of '../../cv_page.dart';

pw.Widget buildPdfAboutSection(CVState state, pw.Font font, pw.Font boldFont) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(
        'About',
        style: pw.TextStyle(
          font: boldFont,
          fontSize: 18,
        ),
      ),
      pw.Divider(thickness: 1.5),
      pw.SizedBox(height: 8),
      pw.RichText(
        textAlign: pw.TextAlign.justify,
        text: pw.TextSpan(
          style: pw.TextStyle(
            font: font,
            fontSize: 12,
          ),
          text: state.profileEntity!.profile['about'],
        ),
      ),
      pw.SizedBox(height: 16),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Competencies: ',
            style: pw.TextStyle(
              font: boldFont,
              fontSize: 12,
            ),
          ),
          pw.Expanded(
            child: pw.Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(
                state.profileEntity!.competencies.length,
                (index) {
                  final competency = state.profileEntity!.competencies[index];
                  final isLast =
                      index == state.profileEntity!.competencies.length - 1;
                  return pw.Text(
                    isLast ? competency : "$competency,",
                    style: pw.TextStyle(font: font, fontSize: 12),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      pw.SizedBox(height: 16),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Stacks: ',
            style: pw.TextStyle(
              font: boldFont,
              fontSize: 12,
            ),
          ),
          pw.Expanded(
            child: pw.Wrap(
              spacing: 4,
              runSpacing: 4,
              children: List.generate(
                state.profileEntity!.stacks.length,
                (index) {
                  final stack = state.profileEntity!.stacks[index];
                  final isLast =
                      index == state.profileEntity!.stacks.length - 1;
                  return pw.Text(
                    isLast ? stack : "$stack,",
                    style: pw.TextStyle(font: font, fontSize: 12),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
