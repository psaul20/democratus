// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:democratus/converters/date_converters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:democratus/converters/string_converters.dart';

class Package {
  Package({
    this.originChamber,
    this.session,
    this.detailsLink,
    this.shortTitle,
    required this.longTitle,
    this.branch,
    this.download,
    this.pages,
    required this.dateIssued,
    this.currentChamber,
    this.billVersion,
    this.billType,
    required this.packageId,
    this.collectionCode,
    this.governmentAuthor1,
    this.publisher,
    required this.docClass,
    this.lastModified,
    this.category,
    this.billNumber,
    this.congress,
    this.isSaved = false,
    this.hasHtml,
    this.hasDetails = false,
    required this.displayTitle,
    this.typeVerbose,
  });
  // Driven by GovInfo data structure
  final String? originChamber;
  final String? session;
  final String? detailsLink;
  final Map? shortTitle;
  final String? longTitle;
  final String? branch;
  final Map? download;
  final int? pages;
  final DateTime dateIssued;
  final String? currentChamber;
  final String? billVersion;
  final String? billType;
  final String packageId;
  final String? collectionCode;
  final String? governmentAuthor1;
  final String? publisher;
  final String docClass;
  final DateTime? lastModified;
  final String? category;
  final int? billNumber;
  final String? congress;

  // Driven by app logic needs
  bool isSaved;
  bool? hasHtml;
  bool hasDetails;
  String displayTitle;
  String? typeVerbose;

  List<Widget> getTextWidgets({TextStyle? style}) {
    return [
      Text(
        "Full Title: ${StringConverters.toTitleCase(longTitle) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Author: ${StringConverters.toTitleCase(governmentAuthor1) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Category: ${StringConverters.toTitleCase(category) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Type: ${typeVerbose ?? billType ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Branch: ${StringConverters.toTitleCase(branch) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Origin Chamber: ${StringConverters.toTitleCase(originChamber) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Current Chamber: ${StringConverters.toTitleCase(currentChamber) ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Pages: ${pages?.toString() ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Publisher: ${publisher ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Congress: ${congress ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Text(
        "Bill Number: ${billNumber?.toString() ?? "Unknown"}",
        textAlign: TextAlign.start,
        style: style,
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          "Last Action: ${lastModified != null ? DateConverters.formatDate(lastModified!) : "Unknown"}",
          textAlign: TextAlign.start,
          style: style,
        ),
      )
    ];
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      originChamber:
          map['originChamber'] != null ? map['originChamber'] as String : null,
      session: map['session'] != null ? map['session'] as String : null,
      detailsLink:
          map['detailsLink'] != null ? map['detailsLink'] as String : null,
      shortTitle: map['shortTitle']?[0] ?? {'title': map['title']},
      longTitle: map['shortTitle'] != null ? map['title'] as String : null,
      branch: map['branch'] != null ? map['branch'] as String : null,
      download: map['download'] != null
          ? map['download'] as Map<String, dynamic>
          : null,
      pages: map['pages'] != null ? int.parse(map['pages']) : null,
      dateIssued: DateTime.parse(map['dateIssued']),
      currentChamber: map['currentChamber'] != null
          ? map['currentChamber'] as String
          : null,
      billVersion:
          map['billVersion'] != null ? map['billVersion'] as String : null,
      billType: map['billType'] != null ? map['billType'] as String : null,
      packageId: map['packageId'] as String,
      collectionCode: map['collectionCode'] != null
          ? map['collectionCode'] as String
          : null,
      governmentAuthor1: map['governmentAuthor1'] != null
          ? map['governmentAuthor1'] as String
          : null,
      publisher: map['publisher'] != null ? map['publisher'] as String : null,
      docClass: map['docClass'] as String,
      lastModified: map['lastModified'] != null
          ? DateTime.parse(map['lastModified'])
          : null,
      category: map['category'] != null ? map['category'] as String : null,
      billNumber:
          map['billNumber'] != null ? int.parse(map['billNumber']) : null,
      congress: map['congress'] != null ? map['congress'] as String : null,
      hasHtml: map['download']?['txtLink'] != null ? true : false,
      displayTitle: map['shortTitle'] != null
          ? map['shortTitle'][0]['title'] as String
          : map['title'] as String,
      typeVerbose:
          map['billType'] != null ? getTypeVerbose(map['billType']) : null,
    );
  }

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Package.fromPackage(Package package) => package.copyWith();

  Package copyWith({
    String? originChamber,
    String? session,
    String? detailsLink,
    Map? shortTitle,
    String? longTitle,
    String? branch,
    Map? download,
    int? pages,
    DateTime? dateIssued,
    String? currentChamber,
    String? billVersion,
    String? billType,
    String? packageId,
    String? collectionCode,
    String? governmentAuthor1,
    String? publisher,
    String? docClass,
    DateTime? lastModified,
    String? category,
    int? billNumber,
    String? congress,
    bool? isSaved,
    bool? hasHtml,
    bool? hasDetails,
    String? displayTitle,
  }) {
    return Package(
      originChamber: originChamber ?? this.originChamber,
      session: session ?? this.session,
      detailsLink: detailsLink ?? this.detailsLink,
      shortTitle: shortTitle ?? this.shortTitle,
      longTitle: longTitle ?? this.longTitle,
      branch: branch ?? this.branch,
      download: download ?? this.download,
      pages: pages ?? this.pages,
      dateIssued: dateIssued ?? this.dateIssued,
      currentChamber: currentChamber ?? this.currentChamber,
      billVersion: billVersion ?? this.billVersion,
      billType: billType ?? this.billType,
      packageId: packageId ?? this.packageId,
      collectionCode: collectionCode ?? this.collectionCode,
      governmentAuthor1: governmentAuthor1 ?? this.governmentAuthor1,
      publisher: publisher ?? this.publisher,
      docClass: docClass ?? this.docClass,
      lastModified: lastModified ?? this.lastModified,
      category: category ?? this.category,
      billNumber: billNumber ?? this.billNumber,
      congress: congress ?? this.congress,
      isSaved: isSaved ?? this.isSaved,
      hasHtml: hasHtml ?? this.hasHtml,
      hasDetails: hasDetails ?? this.hasDetails,
      displayTitle: displayTitle ?? this.displayTitle,
    );
  }
}

// Defining type list based on https://www.govinfo.gov/help/bills#types
String getTypeVerbose(billType) {
  Map typeList = {
    'hr': 'House Bill',
    's': 'Senate Bill',
    'hjres': 'House Joint Resolution',
    'sjres': 'Senate Joint Resolution',
    'hconres': 'House Concurrent Resolution',
    'sconres': 'Senate Concurrent Resolution',
    'hres': 'House Simple Resolution',
    'sres': 'Senate Simple Resolution',
  };
  if (typeList.keys.contains(billType)) {
    return typeList[billType];
  } else {
    return "Not Mapped";
  }
}

class PackageProvider extends StateNotifier<Package> {
  PackageProvider(package) : super(Package.fromPackage(package));
  void updatePackage(Package package) {
    state = package;
  }

  void toggleSave() {
    state = state.copyWith(isSaved: !state.isSaved);
  }
}

// TODO: Remove ChangeNotifier - convert to simply json getter class
class PackageList extends ChangeNotifier {
  PackageList({List<Package> packages = const []}) : _packages = packages;
  List<Package> _packages;

  int get numPackages => _packages.length;
  Package getPackageByIndex(int index) => _packages[index];
  List<Package> get packages => _packages;

  void add(Package package) {
    _packages.add(package);
    notifyListeners();
  }

  void removeAll() {
    _packages.clear();
    notifyListeners();
  }

  void remove(Package package) {
    _packages.remove(package);
    notifyListeners();
  }

  void replace(List<Package> packages) {
    _packages = packages;
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'proposals': proposals.map((x) => x.toMap()).toList(),
  //   };
  // }

  factory PackageList.fromMap(Map<String, dynamic> map) {
    List<Package> packages = List<Package>.from(
      (map['packages'] as List<dynamic>).map<Package>(
        (x) => Package.fromMap(x as Map<String, dynamic>),
      ),
    );
    return PackageList(packages: packages);
  }

  // String toJson() => json.encode(toMap());

  factory PackageList.fromJson(String source) =>
      PackageList.fromMap(json.decode(source) as Map<String, dynamic>);
}
