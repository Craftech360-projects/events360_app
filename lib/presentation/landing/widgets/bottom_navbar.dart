// import 'package:events360/core/constants/constants.dart';
// import 'package:events360/core/themes/app_colors.dart';
// import 'package:flutter/material.dart';

// ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

// class BottomNavbarWidget extends StatelessWidget {
//   const BottomNavbarWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return ValueListenableBuilder(
//       valueListenable: indexChangeNotifier,
//       builder: (context, int newIndex, _) {
//         return Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.grey.withValues(alpha: 0.1),
//                 spreadRadius: 1,
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: Constants.br16,
//             child: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed,
//               backgroundColor:
//                   isDarkMode ? AppColors.greyDark : AppColors.black,
//               onTap: (index) => indexChangeNotifier.value = index,
//               currentIndex: newIndex,
//               selectedItemColor: AppColors.blue,
//               unselectedItemColor: AppColors.grey,
//               items: const [
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.home_rounded), label: 'Home'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.mic_rounded), label: 'Speaker'),
//                 BottomNavigationBarItem(
//                     icon: Icon(Icons.person), label: 'Profile'),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
