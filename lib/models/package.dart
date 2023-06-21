// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Package {
  Package(
    this.originChamber,
    this.session,
    this.detailsLink,
    this.shortTitle,
    this.title,
    this.branch,
    this.download,
    this.pages,
    this.dateIssued,
    this.currentChamber,
    this.billVersion,
    this.billType,
    this.packageId,
    this.collectionCode,
    this.governmentAuthor1,
    this.publisher,
    this.docClass,
    this.lastModified,
    this.category,
    this.billNumber,
    this.congress,
  );
  final String? originChamber;
  final String? session;
  final String? detailsLink;
  final List? shortTitle;
  final String title;
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
  final DateTime lastModified;
  final String? category;
  final int? billNumber;
  final String? congress;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originChamber': originChamber,
      'session': session,
      'detailsLink': detailsLink,
      'shortTitle': shortTitle,
      'title': title,
      'branch': branch,
      'download': download,
      'pages': pages,
      'dateIssued': dateIssued.millisecondsSinceEpoch,
      'currentChamber': currentChamber,
      'billVersion': billVersion,
      'billType': billType,
      'packageId': packageId,
      'collectionCode': collectionCode,
      'governmentAuthor1': governmentAuthor1,
      'publisher': publisher,
      'docClass': docClass,
      'lastModified': lastModified.millisecondsSinceEpoch,
      'category': category,
      'billNumber': billNumber,
      'congress': congress,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      map['originChamber'] != null ? map['originChamber'] as String : null,
      map['session'] != null ? map['session'] as String : null,
      map['detailsLink'] != null ? map['detailsLink'] as String : null,
      map['shortTitle'] != null ? List.from(map['shortTitle']) : null,
      map['title'] as String,
      map['branch'] != null ? map['branch'] as String : null,
      map['download'] != null ? map['download'] as Map<String, dynamic> : null,
      map['pages'] != null ? map['pages'] as int : null,
      DateTime.parse(map['dateIssued']),
      map['currentChamber'] != null ? map['currentChamber'] as String : null,
      map['billVersion'] != null ? map['billVersion'] as String : null,
      map['billType'] != null ? map['billType'] as String : null,
      map['packageId'] as String,
      map['collectionCode'] != null ? map['collectionCode'] as String : null,
      map['governmentAuthor1'] != null
          ? map['governmentAuthor1'] as String
          : null,
      map['publisher'] != null ? map['publisher'] as String : null,
      map['docClass'] as String,
      DateTime.parse(map['lastModified']),
      map['category'] != null ? map['category'] as String : null,
      map['billNumber'] != null ? map['billNumber'] as int : null,
      map['congress'] != null ? map['congress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);
}

class PackageList extends ChangeNotifier {
  PackageList(this.packages);
  final List<Package> packages;

  int get numProposals => packages.length;
  Package getProposalByIndex(int index) => packages[index];

  void add(Package proposal) {
    packages.add(proposal);
    notifyListeners();
  }

  void removeAll() {
    packages.clear();
    notifyListeners();
  }

  void remove(Package proposal) {
    packages.remove(proposal);
    notifyListeners();
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'proposals': proposals.map((x) => x.toMap()).toList(),
  //   };
  // }

  factory PackageList.fromMap(Map<String, dynamic> map) {
    return PackageList(
      List<Package>.from(
        (map['packages'] as List<dynamic>).map<Package>(
          (x) => Package.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  // String toJson() => json.encode(toMap());

  factory PackageList.fromJson(String source) =>
      PackageList.fromMap(json.decode(source) as Map<String, dynamic>);
}
