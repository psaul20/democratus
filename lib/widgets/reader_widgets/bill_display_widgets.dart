import 'package:democratus/globals/converters/date_converters.dart';
import 'package:democratus/models/bill_models/bill.dart';
import 'package:democratus/theming/text_styles.dart';
import 'package:flutter/material.dart';

class BillDisplay {
  final Bill bill;
  final BuildContext context;
  BillDisplay(this.bill, this.context);

  EdgeInsets get padding => const EdgeInsets.fromLTRB(0, 0, 0, 8);

  Widget divider(String title, {bool topSpace = true}) {
    return Column(
      children: [
        topSpace ? const SizedBox(height: 16.0) : const SizedBox.shrink(),
        Text(
          title.toUpperCase(),
          style: TextStyles(context).headerStyle,
          textAlign: TextAlign.center,
        ),
        const Divider(
          thickness: 4,
        ),
      ],
    );
  }

  Widget displayNumber() {
    return Text(bill.displayNumber, style: TextStyles(context).appBarStyleAlt);
  }

  Widget displayTitle() {
    return Column(
      children: [
        Text(bill.displayTitle,
            style: TextStyles(context)
                .headerStyle
                .copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 16.0),
      ],
    );
  }

  //TODO: Add status

  Widget displaySummaries() {
    List<Widget> returnWidgets = [];
    if (bill.crsSummaries != null) {
      returnWidgets.add(divider('Congressional Research Service Summary'));
      returnWidgets.add(
        Padding(
            padding: padding,
            child: Text(bill.crsSummaries!.first,
                style: TextStyles(context).bodyStyle)),
      );

      return Wrap(
        children: returnWidgets,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget displayBackgroundInfo() {
    List<Widget> returnWidgets = [];
    returnWidgets.add(divider('Background', topSpace: false));
    returnWidgets.add(Padding(
      padding: padding,
      child: displayCongress(),
    ));
    returnWidgets.add(Padding(
      padding: padding,
      child: displayChamber(),
    ));
    returnWidgets.addAll(displayDates());
    returnWidgets.add(Padding(
      padding: padding,
      child: displayPolicyArea(),
    ));
    returnWidgets.addAll(displaySubjects() ?? []);
    return Wrap(spacing: 8.0, children: returnWidgets);
  }

  Widget displaySource() {
    if (bill.source != null) {
      return RichText(
        text: TextSpan(
          style: TextStyles(context).bodyStyle,
          children: [
            const TextSpan(
                text: 'Source: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: bill.source!.name),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget displayChamber() {
    if (bill.originChamber != null) {
      return RichText(
        text: TextSpan(
          style: TextStyles(context).bodyStyle,
          children: [
            const TextSpan(
                text: 'Chamber: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: bill.originChamber!),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  List<Widget>? displaySubjects() {
    List<Widget> returnWidgets = [];
    if (bill.subjects != null) {
      returnWidgets.add(Padding(
        padding: padding,
        child: RichText(
          text: TextSpan(
            style: TextStyles(context).bodyStyle,
            children: [
              const TextSpan(
                  text: 'Subjects: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              for (final subject in bill.subjects!)
                TextSpan(text: '$subject; '),
            ],
          ),
        ),
      ));
      return returnWidgets;
    }
    return null;
  }

  Widget displayPolicyArea() {
    if (bill.policyArea != null) {
      return RichText(
        text: TextSpan(
          style: TextStyles(context).bodyStyle,
          children: [
            const TextSpan(
                text: 'Policy Area: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: bill.policyArea!),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget displayCongress() {
    return RichText(
      text: TextSpan(
        style: TextStyles(context).bodyStyle,
        children: [
          const TextSpan(
              text: 'Congress: ',
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: bill.congress.toString()),
        ],
      ),
    );
  }

  List<Widget> displayDates() {
    List<Widget> returnWidgets = [];
    for (final date in bill.datesForDisplay) {
      if (date != null) {
        returnWidgets.add(
          Padding(
            padding: padding,
            child: RichText(
              text: TextSpan(
                style: TextStyles(context).bodyStyle,
                children: [
                  const TextSpan(
                      text: 'Introduced: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: DateConverters.formatDate(bill.introducedDate!)),
                ],
              ),
            ),
          ),
        );
      }
    }
    return returnWidgets;
  }

  Widget displayActions() {
    if (bill.actions != null) {
      List<Widget> returnWidgets = [];
      returnWidgets.add(divider('Actions'));
      for (final action in bill.actions!) {
        returnWidgets.add(Column(
          children: [
            Center(
              child: Text(DateConverters.formatDate(action.actionDate),
                  style: TextStyles(context)
                      .bodyStyle
                      .copyWith(fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            RichText(
              text: TextSpan(
                style: TextStyles(context).bodyStyle,
                children: [
                  TextSpan(
                      text: '${action.chamber} Action: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: action.description),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ));
      }
      return Wrap(
        children: returnWidgets,
      );
    }

    return RichText(
        text: TextSpan(
      style: Theme.of(context).textTheme.bodyLarge,
      children: [
        const TextSpan(
            text: 'Latest Action: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        TextSpan(text: bill.latestAction),
      ],
    ));
  }

  Widget displaySponsors() {
    List<Widget> returnWidgets = [];
    returnWidgets.add(divider('Sponsors'));
    if (bill.sponsors != null) {
      for (final sponsor in bill.sponsors!) {
        returnWidgets.add(RichText(
          text: TextSpan(
            style: TextStyles(context).bodyStyle,
            children: [
              TextSpan(
                  text: '${sponsor.sponsorName} ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '(${sponsor.sponsorParty}) - '),
              TextSpan(text: '${sponsor.sponsorState}; '),
            ],
          ),
        ));
      }
    }
    return Wrap(
      children: returnWidgets,
    );
  }
}
