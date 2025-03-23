part of '../cv_page.dart';

class StickyActionButtons extends StatelessWidget {
  final VoidCallback onPrint;
  final VoidCallback onDownloadPDF;
  final VoidCallback onDownloadPNG;
  final VoidCallback onDownloadJPG;

  const StickyActionButtons({
    super.key,
    required this.onPrint,
    required this.onDownloadPDF,
    required this.onDownloadPNG,
    required this.onDownloadJPG,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.print,
          tooltip: 'Print',
          onPressed: onPrint,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.picture_as_pdf,
          tooltip: 'Download PDF',
          onPressed: onDownloadPDF,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.image,
          tooltip: 'Download PNG',
          onPressed: onDownloadPNG,
        ),
        const SizedBox(height: 12),
        _buildActionButton(
          icon: Icons.photo,
          tooltip: 'Download JPG',
          onPressed: onDownloadJPG,
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
