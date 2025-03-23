part of '../cv_page.dart';

Widget buildHeader(BuildContext context, CVState state) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.profileEntity!.profile['name'],
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              state.profileEntity!.profile['role'],
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            BlocProvider(
              create: (_) => HoverCubit(),
              child: BlocBuilder<HoverCubit, bool>(
                builder: (context, isHovered) {
                  return MouseRegion(
                    onEnter: (_) => context.read<HoverCubit>().enter(),
                    onExit: (_) => context.read<HoverCubit>().exit(),
                    child: InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        final encodedLocation = Uri.encodeComponent(
                            state.profileEntity!.profile['location']);
                        final mapsUrl =
                            'https://www.google.com/maps/search/?api=1&query=$encodedLocation';
                        urlLauncher(Uri.parse(mapsUrl));
                      },
                      child: buildInfoRow(
                        icon: Icons.location_on,
                        text: state.profileEntity!.profile['location'],
                        isHovered: isHovered,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            buildSocialLinks(state.socials),
          ],
        ),
      ),
    ],
  );
}
