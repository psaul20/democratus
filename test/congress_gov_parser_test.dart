//create uri from the example url

import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

void main() async {
  String url =
      "https://www.congress.gov/advanced-search/legislation?congresses%5B%5D=118&congresses%5B%5D=117&congresses%5B%5D=116&legislationNumbers=&restrictionType=includeBillText&restrictionFields%5B%5D=allBillTitles&restrictionFields%5B%5D=summary&summaryField=billSummary&enterTerms=&wordVariants=true&legislationTypes%5B%5D=hr&legislationTypes%5B%5D=hjres&legislationTypes%5B%5D=s&legislationTypes%5B%5D=sjres&public=true&private=true&chamber=all&actionTerms=&legislativeActionWordVariants=true&dateOfActionOperator=equal&dateOfActionStartDate=&dateOfActionEndDate=&dateOfActionIsOptions=yesterday&dateOfActionToggle=multi&legislativeAction=Any&sponsorState=One&member=&sponsorTypes%5B%5D=sponsor&sponsorTypeBool=OR&dateOfSponsorshipOperator=equal&dateOfSponsorshipStartDate=&dateOfSponsorshipEndDate=&dateOfSponsorshipIsOptions=yesterday&committeeActivity%5B%5D=0&committeeActivity%5B%5D=3&committeeActivity%5B%5D=11&committeeActivity%5B%5D=12&committeeActivity%5B%5D=4&committeeActivity%5B%5D=2&committeeActivity%5B%5D=5&committeeActivity%5B%5D=9&satellite=%5B%5D&search=&submitted=Submitted&1ddcb92ade31c8fbd370001f9b29a7d9=628cb5675ff524f3e719b7aa2e88fe3f&fieldsToInclude=latestTitle,amendsBill,sponsor,dateOffered,dateOfIntroduction,numberOfCosponsors,dateSubmitted,dateProposed,committees,latestAction,latestActionDate,cosponsors,subjects,relatedBillsCount,relatedBill,latestSummary";

  // String url =
  //     'https://www.congress.gov/advanced-search/legislation?congresses%5B%5D=118&congresses%5B%5D=117&congresses%5B%5D=116&legislationNumbers=&restrictionType=includeBillText&restrictionFields%5B%5D=allBillTitles&restrictionFields%5B%5D=summary&summaryField=billSummary&enterTerms=&wordVariants=true&legislationTypes%5B%5D=hr&legislationTypes%5B%5D=hjres&legislationTypes%5B%5D=s&legislationTypes%5B%5D=sjres&public=true&private=true&chamber=all&actionTerms=&legislativeActionWordVariants=true&dateOfActionOperator=equal&dateOfActionStartDate=&dateOfActionEndDate=&dateOfActionIsOptions=yesterday&dateOfActionToggle=multi&legislativeAction=Any&sponsorState=One&member=&sponsorTypes%5B%5D=sponsor&sponsorTypeBool=OR&dateOfSponsorshipOperator=equal&dateOfSponsorshipStartDate=&dateOfSponsorshipEndDate=&dateOfSponsorshipIsOptions=yesterday&committeeActivity%5B%5D=0&committeeActivity%5B%5D=3&committeeActivity%5B%5D=11&committeeActivity%5B%5D=12&committeeActivity%5B%5D=4&committeeActivity%5B%5D=2&committeeActivity%5B%5D=5&committeeActivity%5B%5D=9&satellite=%5B%5D&search=&submitted=Submitted';

  Uri example = Uri.parse(url);

  Map<String, String> headers = {
    'User-Agent':
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36",
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
    'Accept-Encoding': 'gzip, deflate, br',
    'Accept-Language': 'en-US,en;q=0.5',
    'Cookie':
        's_ecid=MCMID%7C90003985408402535451933462420417490993; __cfruid=7939a028cb6cf4dc2f6c334ed8bcf399ffa6ce27-1691454713; PHPSESSID=06afff06c792c98390ec33e2f2addd09; AMCVS_0D15148954E6C5100A4C98BC%40AdobeOrg=1; KWICViewCompact-advanced-search-legislation=false; KWICViewExpanded-advanced-search-legislation=true; post-authentication-url=%2Fhelp%2Fsaved-searches; authentication=aa4bd0125beb80921ce815b5ad07dfe2a281753e9e6bffa71795b0c102dea85c%3A545770; KWICViewCompact-search=false; KWICViewExpanded-search=true; KWICViewCompact-billActions=false; KWICViewExpanded-billActions=true; KWICViewCompact-billAllActions=false; KWICViewExpanded-billAllActions=true; AMCV_0D15148954E6C5100A4C98BC%40AdobeOrg=179643557%7CMCMID%7C90003985408402535451933462420417490993%7CMCIDTS%7C19583%7CMCAID%7CNONE%7CMCOPTOUT-1691906696s%7CNONE%7CvVersion%7C5.5.0; __cf_bm=Cz4ismRw5HWPrV7kH4WCeSawTfgsUhxNmR5xiw56RQ4-1691899497-0-AXoHS7JNJFShDfMkEZCvIaQiPPrd+xoB7zBa2NN9VFIZfifXINBT3/cdb4SraruyGHHOYQGhEv+xfs103c+D4gE=',
    'If-Modified-Since': 'Sat, 12 Aug 2023 19:29:02 GMT',
    'Referer':
        'https://www.congress.gov/advanced-search/legislation?congresses%5B%5D=118&congresses%5B%5D=117&congresses%5B%5D=116&legislationNumbers=&restrictionType=includeBillText&restrictionFields%5B%5D=allBillTitles&restrictionFields%5B%5D=summary&summaryField=billSummary&enterTerms=&wordVariants=true&legislationTypes%5B%5D=hr&legislationTypes%5B%5D=hjres&legislationTypes%5B%5D=s&legislationTypes%5B%5D=sjres&public=true&private=true&chamber=all&actionTerms=&legislativeActionWordVariants=true&dateOfActionOperator=equal&dateOfActionStartDate=&dateOfActionEndDate=&dateOfActionIsOptions=yesterday&dateOfActionToggle=multi&legislativeAction=Any&sponsorState=One&member=&sponsorTypes%5B%5D=sponsor&sponsorTypeBool=OR&dateOfSponsorshipOperator=equal&dateOfSponsorshipStartDate=&dateOfSponsorshipEndDate=&dateOfSponsorshipIsOptions=yesterday&committeeActivity%5B%5D=0&committeeActivity%5B%5D=3&committeeActivity%5B%5D=11&committeeActivity%5B%5D=12&committeeActivity%5B%5D=4&committeeActivity%5B%5D=2&committeeActivity%5B%5D=5&committeeActivity%5B%5D=9&satellite=%5B%5D&search=&submitted=Submitted',
    'Sec-Ch-Ua':
        "\"Not/A)Brand\";v=\"99\", \"Brave\";v=\"115\", \"Chromium\";v=\"115\"",
    'Sec-Ch-Ua-Mobile': '?0',
    'Sec-Fetch-Dest': 'document',
    'Sec-Fetch-Mode': 'navigate',
    'Sec-Fetch-Site': 'same-origin',
    'Sec-Fetch-User': '?1',
    'Sec-Gpc': '1',
    'Upgrade-Insecure-Requests': '1',
  };
  example.queryParameters.forEach((key, value) {
    log("$key: $value");
  });

  //write a method which takes in the parameters of the example URL, submits an http request, and returns the response
  Response response = await http.get(example, headers: headers);
  log(response.body);
}
