// import 'package:flutter/material.dart';
// import 'package:readmore/readmore.dart';
//
// import 'model.dart';
//
// String getStageDescription(int? stage) {
//   switch (stage) {
//     case 1:
//       return "Ongoing";
//     case 2:
//       return "Complete";
//     case 3:
//       return "New Update";
//     default:
//       return "Unknown Stage";
//   }
// }
//
//
// final List<String> items = [
//   'Chapters',
//   'Reviews',
//   'Read more',
//   'Related books',
//   'Courses',
// ];
//
// Widget _buildBookImage(BookDetailData data) {
//   return Center(
//     child: Stack(
//       children: [
//         // Book image container
//         Container(
//           height: 395,
//           width: 328,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             // Apply borderRadius to the image
//             child: Image.network(
//               data.bookCoverImage.toString(),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         // Gradient overlay
//         Container(
//           height: 395,
//           width: 328,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.transparent,
//                 Colors.grey.shade50.withOpacity(0.5),
//                 // Adjust opacity for better visual effect
//                 Colors.grey.shade50,
//               ],
//             ),
//           ),
//         ),
//         // Positioned book info at the bottom
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: _buildBookInfo(
//               data.bookName,
//               data.parentCategory.toString(),
//               getStageDescription(data.status)),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildBookInfo(String name, String description, String status) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 16),
//     child: Column(
//       children: [
//         _buildStatusBadge(status),
//         const SizedBox(height: 8),
//         Text(
//           name,
//           style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
//         ),
//         Text(
//           description,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             height: 1.2,
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildReadButton(),
//       ],
//     ),
//   );
// }
//
// Widget _buildStatusBadge(String status) {
//   return Container(
//     width: 79,
//     height: 23,
//     decoration: BoxDecoration(
//       color:   Color.fromRGBO(141, 255, 159, 1),
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Center(
//       child: Text(
//         status,
//         style: TextStyle(color: Colors.black, fontSize: 10),
//       ),
//     ),
//   );
// }
//
// Widget _buildReadButton() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 16),
//     child: GestureDetector(
//       onTap: () {},
//       child: Container(
//         height: 44,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.3),
//           border: Border.all(color: Colors.green, width: 1),
//           borderRadius: BorderRadius.circular(36),
//         ),
//         child: const Center(
//           child: Text(
//             "Read",
//             style: TextStyle(color: Colors.green, fontSize: 16),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// Widget _buildStatsRow(BookDetailData data) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       _buildStatCard(
//           data.bookReadCount.toString(), 'Reads'),
//       _buildStatCard(data.bookRating.toString(), 'Rating'),
//       _buildStatCard(
//           data.totalChapters.toString(), 'Chapters'),
//       _buildStatCard(data.totalPages.toString(), 'Pages'),
//     ],
//   );
// }
//
// Widget _buildStatCard(String numberText, String descriptionText) {
//   return Container(
//     height: 72,
//     width: 72,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(4),
//       color: Colors.white, // Set your container color
//       boxShadow: [
//         BoxShadow(
//           color: Color.fromRGBO(68, 68, 68, 0.04),
//           blurRadius: 12,
//           spreadRadius: 0,
//           offset: Offset(0, 0),
//         ),
//       ],
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           numberText,
//           style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//         ),
//         Text(
//           descriptionText,
//           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//         ),
//       ],
//     ),
//   );
// }
//
// Widget _buildDividerRow(List<dynamic> categories) {
//   List<Widget> categoryWidgets = [];
//
//   for (int i = 0; i < categories.length; i++) {
//     // Add each category's widget
//     categoryWidgets.add(_buildDividerData(
//         categories[i].categoryIcon, categories[i].categoryName));
//
//     // Add a vertical divider after each category, except the last one
//     if (i < categories.length - 1) {
//       categoryWidgets.add(Container(
//         color: Colors.grey,
//         width: 1,
//         height: 29,
//       ));
//     }
//   }
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: categoryWidgets,
//   );
// }
//
// // Category item widget
// Widget _buildDividerData(String iconUrl, String categoryName) {
//   return Column(
//     children: [
//       Image.network(
//         iconUrl,
//         width: 40, // Adjust as per your requirement
//         height: 40,
//         fit: BoxFit.contain,
//       ),
//       SizedBox(height: 5),
//       Text(
//         categoryName,
//         style: TextStyle(fontSize: 12),
//       ),
//     ],
//   );
// }
//
// Widget _buildDescription(String description) {
//   return ReadMoreText(
//     description,
//     trimMode: TrimMode.Line,
//     trimLines: 5,
//     colorClickableText: Colors.pink,
//     trimCollapsedText: ' Read more',
//     trimExpandedText: ' Show Less',
//     moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//   );
// }
//
// Widget _buildDownloadSection() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//       const Text(
//         "Chapters",
//         style: TextStyle(
//           fontSize: 16,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//       _buildDownloadButton(),
//     ],
//   );
// }
//
// Widget _buildDownloadButton() {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(24),
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: Row(
//         children: const [
//           Text(
//             "Download",
//             style: TextStyle(
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey),
//           ),
//           SizedBox(
//             width: 4,
//           ),
//           Icon(
//             Icons.save_alt,
//             size: 18,
//             color: Colors.grey,
//           ),
//         ],
//       ),
//     ),
//   );
// }
// }
// class ChapterListView extends StatelessWidget {
//   final BookDetailData data;
//
//   const ChapterListView({Key? key, required this.data}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           ListView.builder(
//             padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: data.chapters.length,
//             itemBuilder: (context, index) {
//               // Access the chapters in reverse order
//               var chapters = data.chapters[data.chapters.length - 1 - index];
//
//               return Container(
//                 height: 80,
//                 width: MediaQuery.of(context).size.width,
//                 child: Stack(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 14),
//                       child: Container(
//                         width: 2,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: List.generate(
//                             10,
//                                 (index) => Padding(
//                               padding: const EdgeInsets.symmetric(vertical: 1),
//                               child: Container(
//                                 height: 6,
//                                 width: 6,
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade300,
//                                   shape: BoxShape.circle,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 70,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: Colors.grey.shade100,
//                                 radius: 14,
//                                 child: Text("${index + 1}"),
//                               ),
//                             ],
//                           ),
//                           SizedBox(width: 20),
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(4),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Color.fromRGBO(68, 68, 68, 0.04),
//                                     blurRadius: 12,
//                                     spreadRadius: 0,
//                                     offset: Offset(0, 0),
//                                   ),
//                                 ],
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(chapters.chapterName),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Icon(
//                                                   Icons.star,
//                                                   color: Colors.yellow.shade700,
//                                                   size: 16,
//                                                 ),
//                                                 SizedBox(width: 4),
//                                                 Text(
//                                                   data.bookRating.toString(),
//                                                   style: TextStyle(
//                                                     color: Colors.grey.shade700,
//                                                     fontSize: 12,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.symmetric(horizontal: 8),
//                                               child: Container(
//                                                 height: 10,
//                                                 color: Colors.grey,
//                                                 width: 1,
//                                               ),
//                                             ),
//                                             Text(
//                                               "${chapters.pages} pgs",
//                                               style: TextStyle(
//                                                 color: Colors.grey.shade500,
//                                                 fontSize: 12,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Icon(
//                                       Icons.save_alt,
//                                       color: Colors.grey.shade400,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }