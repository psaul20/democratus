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

  Widget displaySummaries() {
    List<Widget> returnWidgets = [];
    if (bill.displaySummary != null) {
      returnWidgets.add(divider('Congressional Research Service Summary'));
      returnWidgets.add(
        Padding(
            padding: padding,
            child: Text(bill.displaySummary!,
                style: TextStyles(context).bodyStyle)),
      );

      return Wrap(
        children: returnWidgets,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget displayBackgroundInfo({bool withDivider = true}) {
    List<Widget> returnWidgets = [];
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
    if (withDivider && returnWidgets.isNotEmpty) {
      returnWidgets = [divider('Background'), ...returnWidgets];
    }
    return Wrap(spacing: 8.0, children: returnWidgets);
  }

  Widget displaySource() {
    return RichText(
      text: TextSpan(
        style: TextStyles(context).bodyStyle,
        children: [
          const TextSpan(
              text: 'Source: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: bill.source.name),
        ],
      ),
    );
  }

  Widget displayChamber() {
    if (bill.displayOriginChamber != null) {
      return RichText(
        text: TextSpan(
          style: TextStyles(context).bodyStyle,
          children: [
            const TextSpan(
                text: 'Chamber: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: bill.displayOriginChamber!),
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
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
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
                  TextSpan(
                      text: date['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: date['date'],
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return returnWidgets;
  }

  Widget? displayActions() {
    List<Widget> returnWidgets = [];
    if (bill.actions != null) {
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
                      text: '${action.displayActionType} Action: ',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: action.description),
                ],
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16.0),
          ],
        ));
      }
    }
    return returnWidgets.isNotEmpty
        ? Wrap(
            children: returnWidgets,
          )
        : null;
  }

  Widget? displaySponsors() {
    List<Widget> returnWidgets = [];

    if (bill.sponsors != null) {
      for (final sponsor in bill.sponsors!) {
        if (sponsor.sponsorFullName != null) {
          returnWidgets.add(RichText(
              text: TextSpan(
            text: '${sponsor.sponsorFullName}; ',
            style: TextStyles(context).bodyStyle,
          )));
        } else {
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
    }
    if (returnWidgets.isNotEmpty) {
      returnWidgets = [divider('Sponsors'), ...returnWidgets];
    }
    return Wrap(
      children: returnWidgets,
    );
  }
}
