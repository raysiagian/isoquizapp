// import 'package:flutter/material.dart';
// import 'package:quiz_iso_app/routes/appRouteConstants.dart';
// import 'package:quiz_iso_app/styles/localColors.dart';
// import 'package:quiz_iso_app/styles/localTextStyle.dart';

// class AnexCardWidget extends StatelessWidget {
//   const AnexCardWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//          Navigator.pushNamed(context, AppRouteConstants.materiCategoryPage);
//       },
//       borderRadius: BorderRadius.circular(8.0),
//       child: Container(
//         width: double.infinity,
//         height: 150.0,
//         padding: EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: LocalColorsStyle.primaryColor,
//           borderRadius: BorderRadius.circular(8.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.25),
//               spreadRadius: 2,
//               blurRadius: 5,
//               offset: Offset(0, 3),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Anex",
//              style: LocalTextStyle.textTheme.titleLarge!.copyWith(
//                   color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               "Belajar Tentang ISO",
//               style: LocalTextStyle.textTheme.titleSmall!.copyWith(
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
