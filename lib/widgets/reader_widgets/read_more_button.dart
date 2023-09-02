import 'package:democratus/archive/bloc/package_bloc.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackageBloc, PackageState>(builder: (context, state) {
      readMore(BuildContext ctx) async {
        Uri url = Uri.parse(state.package.detailsLink ?? '');

        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          throw 'Could not launch $url';
        }

        // Not currently using PackageReader view
        // Navigator.of(ctx).push(
        //   MaterialPageRoute(
        //     builder: (ctx) {
        //       return BlocProvider.value(
        //         value: BlocProvider.of<PackageBloc>(context),
        //         child: const PackageReader(),
        //       );
        //     },
        //   ),
        // );
      }

      if (state.package.hasHtml == true) {
        return Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => readMore(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_outward),
                    Text(
                      "Read More",
                      textAlign: TextAlign.center,
                      style: TextStyles(context).bodyStyle,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
