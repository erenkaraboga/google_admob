import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdExample extends StatefulWidget {
  const BannerAdExample({
    super.key,
  });

  @override
  State<BannerAdExample> createState() => _BannerAdExampleState();
}

class _BannerAdExampleState extends State<BannerAdExample> {

  BannerAd? _bannerAd;
  bool _isLoaded = false;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';
  @override
  void initState() {
    loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd != null && _isLoaded != false
        ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: _bannerAd!.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd!),
        )
        : const SizedBox();
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.fullBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, err) {
          debugPrint('BannerAd failed to load');
          // Dispose the ad here to free resources.
          ad.dispose();
        },
      ),
    )..load();
  }
}
