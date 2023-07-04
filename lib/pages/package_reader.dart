import 'package:democratus/api/govinfo_api.dart';
import 'package:democratus/models/package.dart';
import 'package:democratus/styles/text_styles.dart';
import 'package:democratus/widgets/buttons/save_button.dart';
import 'package:democratus/widgets/package_widgets/package_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageReader extends ConsumerWidget {
  const PackageReader({super.key, required this.packageProvider});
  final StateNotifierProvider<PackageProvider, Package> packageProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Package package = ref.watch(packageProvider);
    return Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          title: Text("Reader"),
          floating: true,
        ),
        SliverList(
            delegate: SliverChildListDelegate(
          [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
              child: Text(
                package.displayTitle,
                style: TextStyles.titleText,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, right: 12.0, left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyles.fieldTitle,
                    textAlign: TextAlign.center,
                  ),
                  PackageDetails(package: package)
                ],
              ),
            ),
            FutureBuilder(
                future: GovinfoApi().getHtml(package),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return const Text("");
                    return Html(data: snapshot.data ?? "");
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                        child: Column(
                      children: [
                        Text("Fetching Text..."),
                        CircularProgressIndicator()
                      ],
                    ));
                  }
                })
          ],
        ))
      ]),
      floatingActionButton: SaveButton(
        packageProvider: packageProvider,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}


// CustomScrollView(
//     slivers: <Widget>[
//       SliverAppBar(
//         title: Text('SliverAppBar'),
//         backgroundColor: Colors.green,
//         expandedHeight: 200.0,
//         flexibleSpace: FlexibleSpaceBar(
//           background: Image.asset('assets/forest.jpg', fit: BoxFit.cover),
//         ),
//       ),
//       SliverFixedExtentList(
//         itemExtent: 150.0,
//         delegate: SliverChildListDelegate(
//           [
//             Container(color: Colors.red),
//             Container(color: Colors.purple),
//             Container(color: Colors.green),
//             Container(color: Colors.orange),
//             Container(color: Colors.yellow),
//             Container(color: Colors.pink),
//           ],
//         ),
//       ),
//     ],
// );