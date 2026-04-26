import 'package:flutter/material.dart';
import 'dart:async';
import '../models/admin_model.dart';

class DocumentCard extends StatefulWidget {
  final AdminDocument document;
  final Color categoryColor;

  const DocumentCard({
    super.key,
    required this.document,
    required this.categoryColor,
  });

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  bool _isDownloaded = false;

  void _startDownload() {
    setState(() {
      _isDownloading = true;
      _downloadProgress = 0.0;
    });

    // Simulate download progress
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      setState(() {
        _downloadProgress += 0.05;
        if (_downloadProgress >= 1.0) {
          _downloadProgress = 1.0;
          _isDownloading = false;
          _isDownloaded = true;
          timer.cancel();
          
          _showDownloadComplete();
        }
      });
    });
  }

  void _showDownloadComplete() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${widget.document.title} berhasil diunduh.',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'BUKA',
          textColor: Colors.white,
          onPressed: () {
            // Simulate open
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black.withAlpha(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFormatBadge(widget.document.format),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.document.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.document.size,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.document.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[800],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            if (_isDownloading)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LinearProgressIndicator(
                    value: _downloadProgress,
                    backgroundColor: Colors.grey[200],
                    color: widget.categoryColor,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 6,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(_downloadProgress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isDownloaded ? null : _startDownload,
                  icon: Icon(_isDownloaded ? Icons.check : Icons.download),
                  label: Text(_isDownloaded ? 'Selesai Diunduh' : 'Download'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.categoryColor,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey[300],
                    disabledForegroundColor: Colors.grey[600],
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormatBadge(DocumentFormat format) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: format.color.withAlpha(25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: format.color.withAlpha(50)),
      ),
      child: Column(
        children: [
          Icon(
            _getFormatIcon(format),
            color: format.color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            format.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: format.color,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getFormatIcon(DocumentFormat format) {
    switch (format) {
      case DocumentFormat.docx:
        return Icons.description;
      case DocumentFormat.pdf:
        return Icons.picture_as_pdf;
      case DocumentFormat.xlsx:
        return Icons.table_chart;
    }
  }
}
