// import 'package:democratus/archive/bloc/package_bloc.dart';
// import 'package:democratus/archive/bloc/saved_package_bloc.dart';
// import 'package:democratus/models/package.dart';
// import 'package:democratus/theming/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SaveButton extends StatelessWidget {
//   const SaveButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Package package = context.watch<PackageBloc>().state.package;
//     saveTap() {
//       //TODO: Add repository to tie these events together
//       context.read<PackageBloc>().add(ToggleSave());

//       if (package.isSaved) {
//         context.read<SavedPackagesBloc>().add(RemovePackage(package: package));
//       } else {
//         context
//             .read<SavedPackagesBloc>()
//             .add(SavePackage(package: package.copyWith(isSaved: true)));
//       }
//     }

//     return Container(
//       width: 50,
//       height: 50,
//       decoration: const BoxDecoration(shape: BoxShape.circle),
//       child: ClipOval(
//         child: Material(
//           color: Colors.transparent,
//           child: InkWell(
//             onTap: saveTap,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(package.isSaved ? Icons.favorite : Icons.favorite_border),
//                 Text(
//                   package.isSaved ? "Saved" : "Save",
//                   textAlign: TextAlign.center,
//                   style: TextStyles.iconText,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
