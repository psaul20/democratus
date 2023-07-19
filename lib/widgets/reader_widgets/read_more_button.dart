// import 'package:democratus/blocs/package_bloc.dart';
// import 'package:democratus/styles/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ReadMoreButton extends StatelessWidget {
//   const ReadMoreButton({super.key, required this.packageBloc});
//   final PackageBloc packageBloc;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PackageBloc, PackageState>(
//         bloc: packageBloc,
//         builder: (context, state) {
//           // readMore(BuildContext context) {
//           //   Navigator.of(context)
//           //       .push(MaterialPageRoute(builder: (BuildContext context) {
//           //     return PackageReader(
//           //       packageBloc: packageBloc,
//           //     );
//           //   }));
//           // }

//           if (state.package.hasHtml == true) {
//             return Container(
//               width: 60,
//               height: 60,
//               decoration: const BoxDecoration(shape: BoxShape.circle),
//               child: ClipOval(
//                 child: Material(
//                   color: Colors.transparent,
//                   child: InkWell(
//                     // onTap: readMore(context),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.chrome_reader_mode_outlined),
//                         Text(
//                           "Read More",
//                           textAlign: TextAlign.center,
//                           style: TextStyles.iconText,
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           } else {
//             return const SizedBox.shrink();
//           }
//         });
//   }
// }
