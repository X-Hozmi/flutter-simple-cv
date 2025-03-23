part of '../cv_page.dart';

Widget buildCompetenciesSection(BuildContext context, CVState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Competencies',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const Divider(thickness: 1.5),
      const SizedBox(height: 8),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: state.profileEntity!.competencies
            .map((competency) => Chip(
                  label: Text(competency),
                  backgroundColor: Colors.grey[200],
                ))
            .toList(),
      ),
    ],
  );
}
