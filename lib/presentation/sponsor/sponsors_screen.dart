// import 'package:events360/core/assets/app_images.dart';
// import 'package:events360/core/constants/constants.dart';
// import 'package:events360/core/themes/app_colors.dart';
// import 'package:events360/data/models/sponsor.dart';
// import 'package:events360/providers/event_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SponsorsScreen extends StatelessWidget {
//   const SponsorsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final eventProvider = Provider.of<EventProvider>(context);
    
//     if (eventProvider.isLoading) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Sponsors', style: Theme.of(context).textTheme.headlineSmall),
//         ),
//         body: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
    
//     final sponsors = eventProvider.sponsors;
    
//     if (sponsors.isEmpty) {
//       return Scaffold(
//         appBar: AppBar(
//           title: Text('Sponsors', style: Theme.of(context).textTheme.headlineSmall),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('No sponsors available'),
//               ElevatedButton(
//                 onPressed: () => eventProvider.refreshEventData(),
//                 child: const Text('Refresh'),
//               ),
//             ],
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sponsors', style: Theme.of(context).textTheme.headlineSmall),
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => eventProvider.refreshEventData(),
//         child: GridView.builder(
//           padding: const EdgeInsets.all(12),
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             childAspectRatio: 0.8,
//             crossAxisSpacing: 12,
//             mainAxisSpacing: 12,
//           ),
//           itemCount: sponsors.length,
//           itemBuilder: (context, index) {
//             final sponsor = sponsors[index];
//             return Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: isDarkMode ? AppColors.greyDark : AppColors.white,
//                 borderRadius: Constants.br12,
//                 boxShadow: [
//                   BoxShadow(
//                     color: AppColors.grey.withValues(alpha: 0.1),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: ClipRRect(
//                       borderRadius: Constants.br8,
//                       child: sponsor.logoUrl.isNotEmpty
//                           ? Image.network(
//                               sponsor.logoUrl,
//                               fit: BoxFit.contain,
//                               errorBuilder: (context, error, stackTrace) {
//                                 return Image.asset(
//                                   AppImages.userPlaceholder,
//                                   fit: BoxFit.contain,
//                                 );
//                               },
//                             )
//                           : Image.asset(
//                               AppImages.userPlaceholder,
//                               fit: BoxFit.contain,
//                             ),
//                     ),
//                   ),
//                   Constants.h8,
//                   Text(
//                     sponsor.name,
//                     style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                           fontWeight: FontWeight.bold,
//                         ),
//                     textAlign: TextAlign.center,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Constants.h4,
//                   Text(
//                     '${sponsor.tier} • Booth ${sponsor.booth}',
//                     style: Theme.of(context).textTheme.bodySmall,
//                     textAlign: TextAlign.center,
//                   ),
//                   Constants.h8,
//                   OutlinedButton(
//                     onPressed: () {
//                       _showSponsorDetails(context, sponsor);
//                     },
//                     style: OutlinedButton.styleFrom(
//                       minimumSize: const Size.fromHeight(36),
//                     ),
//                     child: const Text('More Info'),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   void _showSponsorDetails(BuildContext context, Sponsor sponsor) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(),
//       builder: (context) {
//         return Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? AppColors.greyDark
//                 : AppColors.white,
//             borderRadius: Constants.br12,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: Constants.br8,
//                         child: sponsor.logoUrl.isNotEmpty
//                             ? Image.network(
//                                 sponsor.logoUrl,
//                                 height: 100,
//                                 fit: BoxFit.contain,
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return Image.asset(
//                                     AppImages.userPlaceholder,
//                                     height: 100,
//                                     fit: BoxFit.contain,
//                                   );
//                                 },
//                               )
//                             : Image.asset(
//                                 AppImages.userPlaceholder,
//                                 height: 100,
//                                 fit: BoxFit.contain,
//                               ),
//                       ),
//                       Constants.h16,
//                       Text(
//                         sponsor.name,
//                         style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                         textAlign: TextAlign.center,
//                       ),
//                       Constants.h4,
//                       Text(
//                         '${sponsor.tier} Sponsor',
//                         style: Theme.of(context).textTheme.titleMedium,
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Constants.h24,
//                 const Divider(),
//                 Constants.h16,
//                 _buildInfoRow(context, 'Booth', sponsor.booth),
//                 Constants.h8,
//                 _buildInfoRow(context, 'Website',
//                 "Need to add",
//                 // sponsor.website,
//                 ),
//                 Constants.h24,
//                 Text(
//                   'About',
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.bold,
//                       ),
//                 ),
//                 Constants.h8,
//                 Text(
//                 "Need to add",
//                   // sponsor.description,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyLarge
//                       ?.copyWith(height: 1.2),
//                 ),
//                 Constants.h32,
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Open website or contact
//                       Navigator.pop(context);
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Opening sponsor website...'),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: Constants.br8,
//                       ),
//                     ),
//                     child: const Text('Visit Website'),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildInfoRow(BuildContext context, String label, String value) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(
//           width: 80,
//           child: Text(
//             label,
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                 ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ),
//       ],
//     );
//   }
// }