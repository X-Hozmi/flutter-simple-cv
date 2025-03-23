part of '../cv_page.dart';

Widget buildSocialLinks(List<Map<String, dynamic>> socials) {
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: socials.map((social) {
      IconData getIcon() {
        switch (social['icon']) {
          case 'envelope':
            return FontAwesomeIcons.envelope;
          case 'phone':
            return FontAwesomeIcons.phone;
          case 'github':
            return FontAwesomeIcons.github;
          case 'linkedin':
            return FontAwesomeIcons.linkedin;
          case 'instagram':
            return FontAwesomeIcons.instagram;
          default:
            return FontAwesomeIcons.link;
        }
      }

      return SocialLink(
        icon: getIcon(),
        url: social['url'],
        hoverCubit: HoverCubit(),
      );
    }).toList(),
  );
}

class SocialLink extends StatelessWidget {
  final IconData icon;
  final String url;
  final HoverCubit hoverCubit;

  const SocialLink({
    super.key,
    required this.icon,
    required this.url,
    required this.hoverCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HoverCubit, bool>(
      bloc: hoverCubit,
      builder: (context, isHovered) {
        final hoveredTransform = Matrix4.identity()..scale(1.1);
        final transform = isHovered ? hoveredTransform : Matrix4.identity();

        return MouseRegion(
          onEnter: (_) => hoverCubit.enter(),
          onExit: (_) => hoverCubit.exit(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: transform,
            child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => urlLauncher(Uri.parse(url)),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(4),
                  color: isHovered ? Colors.grey[100] : Colors.transparent,
                ),
                child: FaIcon(
                  icon,
                  size: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
