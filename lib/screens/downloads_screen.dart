import 'package:flutter/material.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  final List<Map<String, String>> downloadedMaterials = [
    {
      'title': 'Introduction to Programming',
      'course': 'CS101 • Lecture Notes',
      'type': 'PDF',
      'size': '2.4 MB',
    },
    {
      'title': 'Database Management Systems',
      'course': 'DB201 • Study Notes',
      'type': 'PDF',
      'size': '3.1 MB',
    },
    {
      'title': 'Web Design and Development',
      'course': 'WD301 • Course Notes',
      'type': 'PDF',
      'size': '2.8 MB',
    },
  ];

  void _openMaterial(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$title selected.'),
      ),
    );
  }

  void _deleteMaterial(int index) {
    final materialName = downloadedMaterials[index]['title']!;

    setState(() {
      downloadedMaterials.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$materialName removed from downloads.'),
      ),
    );
  }

  void _clearAllDownloads() {
    if (downloadedMaterials.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('There are no downloaded materials.'),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Downloads'),
          content: const Text(
            'Are you sure you want to remove all downloaded '
            'materials from this list?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  downloadedMaterials.clear();
                });

                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'All downloads have been removed.',
                    ),
                  ),
                );
              },
              child: const Text('CLEAR'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalFiles = downloadedMaterials.length;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black87,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Text(
          'Downloads',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _clearAllDownloads,
            icon: const Icon(
              Icons.delete_sweep_outlined,
              color: Colors.black87,
            ),
            tooltip: 'Clear downloads',
          ),
        ],
      ),

      // ---------------- BODY ----------------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Page title
              const Text(
                'Downloaded Materials',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Access your saved learning materials '
                'without an internet connection.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 25),

              // Storage information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.folder_outlined,
                        size: 30,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$totalFiles Materials',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          const Text(
                            'Available for offline learning',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Section heading
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Downloads',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  if (downloadedMaterials.isNotEmpty)
                    TextButton(
                      onPressed: _clearAllDownloads,
                      child: const Text(
                        'Clear All',
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 10),

              // Downloaded materials
              if (downloadedMaterials.isEmpty)
                _emptyDownloads()
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: downloadedMaterials.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                  itemBuilder: (context, index) {
                    final material =
                        downloadedMaterials[index];

                    return _downloadCard(
                      title: material['title']!,
                      course: material['course']!,
                      type: material['type']!,
                      size: material['size']!,
                      onTap: () {
                        _openMaterial(
                          material['title']!,
                        );
                      },
                      onDelete: () {
                        _deleteMaterial(index);
                      },
                    );
                  },
                ),

              const SizedBox(height: 25),

              // Offline information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.wifi_off_outlined,
                      size: 30,
                      color: Colors.blue.shade700,
                    ),

                    const SizedBox(width: 14),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Your downloaded materials can be '
                            'accessed when you do not have an '
                            'internet connection.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- DOWNLOAD CARD ----------------
  Widget _downloadCard({
    required String title,
    required String course,
    required String type,
    required String size,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),

      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            // Download icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.download_done_outlined,
                color: Colors.green.shade700,
                size: 28,
              ),
            ),

            const SizedBox(width: 14),

            // Material details
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    course,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Row(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius:
                              BorderRadius.circular(6),
                        ),
                        child: Text(
                          type,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        size,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Delete button
            IconButton(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red.shade400,
              ),
              tooltip: 'Remove',
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- EMPTY DOWNLOADS ----------------
  Widget _emptyDownloads() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.download_for_offline_outlined,
            size: 60,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 15),

          const Text(
            'No Downloads Yet',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Downloaded learning materials will '
            'appear here.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}