
import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/learning_material.dart';
import '../services/offline_download_service.dart';

class LearningMaterialsScreen extends StatefulWidget {
  const LearningMaterialsScreen({super.key});

  @override
  State<LearningMaterialsScreen> createState() =>
      _LearningMaterialsScreenState();
}

class _LearningMaterialsScreenState
    extends State<LearningMaterialsScreen> {
  String selectedCategory = 'All';
final TextEditingController searchController = TextEditingController();
String searchQuery = '';
  final List<LearningMaterial> materials = learningMaterials;

  final List<String> categories = [
    'All',
    'Notes',
    'PDF',
    'Videos',
    'Assignments',
  ];

  void _openMaterial(String materialName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$materialName selected.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Learning Materials',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'More options will be available here.',
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black87,
            ),
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

              // ---------------- INTRODUCTION ----------------
              const Text(
                'Learning Materials',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Find lecture notes, PDFs, videos and other '
                'study resources.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- SEARCH ----------------
              TextField(
                controller: searchController,
  onChanged: (value) {
    setState(() {
      searchQuery = value.toLowerCase();
    });
  },
                decoration: InputDecoration(
                  hintText: 'Search materials...',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),

                  contentPadding:
                      const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // ---------------- CATEGORIES ----------------
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    final isSelected =
                        selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                      ),
                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,

                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },

                        selectedColor:
                            Colors.blue.shade700,

                        backgroundColor: Colors.white,

                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),

                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // ---------------- MATERIALS TITLE ----------------
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Available Materials',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  Text(
                    '${materials.length} Materials',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ---------------- MATERIALS LIST ----------------
             ...materials
    .where(
      (material) {
        final matchesSearch =
            material.title.toLowerCase().contains(searchQuery) ||
            material.courseCode.toLowerCase().contains(searchQuery) ||
            material.courseName.toLowerCase().contains(searchQuery);

        final matchesCategory =
            selectedCategory == 'All' ||
            material.type.toLowerCase() ==
                selectedCategory.toLowerCase().replaceAll('s', '');

        return matchesSearch && matchesCategory;
      },
    )
    .map(
                (material) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    child: _materialCard(
                      icon: material.type == 'PDF'
                          ? Icons.picture_as_pdf_outlined
                          : material.type == 'Video'
                              ? Icons.play_circle_outline
                              : Icons.assignment_outlined,

                      iconColor: material.type == 'PDF'
                          ? Colors.red.shade600
                          : material.type == 'Video'
                              ? Colors.orange.shade700
                              : Colors.green.shade700,

                      title: material.title,

                      course:
                          '${material.courseCode} • '
                          '${material.courseName}',

                      type: material.type,

                      size: material.size,

                      onTap: () {
                        _openMaterial(
                          material.title,
                        );
                      },
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // ---------------- OFFLINE MESSAGE ----------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(16),
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
                            'Access Materials Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),

                          SizedBox(height: 6),

                          Text(
                            'Download learning materials while '
                            'you have internet access and study '
                            'them later without an internet '
                            'connection.',
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

  // ---------------- MATERIAL CARD ----------------
  Widget _materialCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String course,
    required String type,
    required String size,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),

      child: Container(
        padding: const EdgeInsets.all(15),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(15),

          border: Border.all(
            color: Colors.grey.shade200,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.04,
              ),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        child: Row(
          children: [

            // ---------------- MATERIAL ICON ----------------
            Container(
              width: 52,
              height: 52,

              decoration: BoxDecoration(
                color: iconColor.withValues(
                  alpha: 0.10,
                ),

                borderRadius:
                    BorderRadius.circular(12),
              ),

              child: Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
            ),

            const SizedBox(width: 14),

            // ---------------- MATERIAL INFORMATION ----------------
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    title,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight:
                          FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    course,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,

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
                          color:
                              Colors.grey.shade100,

                          borderRadius:
                              BorderRadius.circular(6),
                        ),

                        child: Text(
                          type,
                          style:
                              const TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      Text(
                        size,
                        style:
                            const TextStyle(
                          fontSize: 11,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

           IconButton(
  onPressed: () async {
    try {
      await OfflineDownloadService.saveMaterial(
        id: title,
        title: title,
        content: 'Learning material: $title\n\n'
            'Course: $course\n'
            'Type: $type\n'
            'Size: $size',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title downloaded for offline reading.'),
        ),
      );
    } catch (e) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'Download error: $e',
      ),
      duration: const Duration(seconds: 5),
    ),
  );
}
  },
  icon: const Icon(
    Icons.download_outlined,
    color: Colors.blue,
  ),
),
          ],
        ),
      ),
    );
  }
}