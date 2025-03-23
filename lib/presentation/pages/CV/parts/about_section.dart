part of '../cv_page.dart';

Widget buildAboutSection(BuildContext context, CVState state) {
  final profile = state.profileEntity!.profile;
  final about = profile['about'].isEmpty ? 'Lorem Ipsum' : profile['about'];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'About',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const Divider(thickness: 1.5),
      const SizedBox(height: 8),
      RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black87,
              ),
          children: _buildRichTextFromAbout(context, about),
        ),
      ),
      const SizedBox(height: 16),
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          Text(
            'Competencies: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ...List.generate(
            state.profileEntity!.competencies.length,
            (index) {
              final competency = state.profileEntity!.competencies[index];
              final isLast =
                  index == state.profileEntity!.competencies.length - 1;
              return _buildCompetitionAndStackTexts(context, competency,
                  isLast: isLast);
            },
          ),
        ],
      ),
      const SizedBox(height: 16),
      Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [
          Text(
            'Stacks: ',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          ...List.generate(
            state.profileEntity!.stacks.length,
            (index) {
              final stack = state.profileEntity!.stacks[index];
              final isLast = index == state.profileEntity!.stacks.length - 1;
              return _buildCompetitionAndStackTexts(context, stack,
                  isLast: isLast);
            },
          ),
        ],
      ),
    ],
  );
}

List<TextSpan> _buildRichTextFromAbout(BuildContext context, String text) {
  final List<String> boldWords = [];

  List<TextSpan> spans = [];
  String remaining = text;

  for (final boldWord in boldWords) {
    if (remaining.contains(boldWord)) {
      final parts = remaining.split(boldWord);
      if (parts.isNotEmpty && parts[0].isNotEmpty) {
        spans.add(TextSpan(text: parts[0]));
      }
      spans.add(
        TextSpan(
          text: boldWord,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      remaining = parts.length > 1 ? parts.sublist(1).join(boldWord) : '';
    }
  }

  if (remaining.isNotEmpty) {
    spans.add(TextSpan(text: remaining));
  }

  return spans;
}

Widget _buildCompetitionAndStackTexts(BuildContext context, String text,
    {bool isLast = false}) {
  return Padding(
    padding: const EdgeInsets.only(right: 4),
    child: Text(
      isLast ? text : "$text,",
      style: Theme.of(context).textTheme.bodyMedium,
    ),
  );
}
