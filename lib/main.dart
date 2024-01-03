import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_admob/banner.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';
   InterstitialAd? _interstitialAd;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text("Ads Example"),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton.icon(
                          onPressed: () {
                            loadAd();
                          },
                          icon: Icon(Icons.refresh),
                          label: Text("Get Interstitial Ad")))),
              const Align(
                  alignment: Alignment.topLeft,
                  child: BannerAdExample()),
            ],
          ),
        ));
  }
   void loadAd() {
     InterstitialAd.load(
         adUnitId: adUnitId,
         request: const AdRequest(),
         adLoadCallback: InterstitialAdLoadCallback(
           onAdLoaded: (ad) {
             debugPrint('$ad loaded.');
             _interstitialAd = ad;
             _interstitialAd?.show();
           },
           onAdFailedToLoad: (LoadAdError error) {
             debugPrint('InterstitialAd failed to load: $error');
           },
         ));
   }
}


