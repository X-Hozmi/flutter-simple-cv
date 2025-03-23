part of '../cv_page.dart';

Widget buildExperienceSection(BuildContext context, CVState state) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Experiences',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      const Divider(thickness: 1.5),
      // const SizedBox(height: 8),
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

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: experience['url'] != null
                        ? BlocProvider(
                            create: (_) => HoverCubit(),
                            child: BlocBuilder<HoverCubit, bool>(
                              builder: (context, isHovered) {
                                return MouseRegion(
                                  onEnter: (_) =>
                                      context.read<HoverCubit>().enter(),
                                  onExit: (_) =>
                                      context.read<HoverCubit>().exit(),
                                  child: InkWell(
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () => urlLauncher(
                                        Uri.parse(experience['url'])),
                                    child: Text(
                                      experience['company'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            decoration: isHovered
                                                ? TextDecoration.underline
                                                : TextDecoration.none,
                                          ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Text(
                            experience['company'],
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        period,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        durationText,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                experience['role'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              if (experience['responsibilites'] != null) ...[
                const SizedBox(height: 12),
                ...experience['responsibilites'].map<Widget>((responsibility) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• '),
                        Expanded(
                          child: Text(
                            responsibility,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
              if (experience['technologies'] != null) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: experience['technologies']
                      .map<Widget>((tech) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ],
          ),
        );
      }),
    ],
  );
}
