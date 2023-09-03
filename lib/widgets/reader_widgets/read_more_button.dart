// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReadMoreButton extends StatelessWidget {
  const ReadMoreButton({
    Key? key,
    required this.url,
  }) : super(key: key);
  final Future<Uri?> url;

  @override
  Widget build(BuildContext context) {
    readMore(BuildContext ctx) async {
      Uri? uri = await url;
      if (uri != null) {
        await launchUrl(uri);
      }
    }

    return FutureBuilder(
      future: url,
      builder: (context, snapshot) {
        bool canLaunch = snapshot.hasData && snapshot.data != null;
        return FloatingActionButton(
          onPressed: canLaunch ? () => readMore(context) : () {},
          heroTag: "readMore",
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: canLaunch
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_outward),
                    Text(
                      "Details",
                      textAlign: TextAlign.center,
                      style: TextStyles(context).fabTextStyle,
                    )
                  ],
                )
              : const CircularProgressIndicator.adaptive(),
        );
      },
    );
  }
}
