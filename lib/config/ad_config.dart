import 'package:flutter/foundation.dart';

// class AdConfig {
//   AdConfig._();
//
//   // Set to false for production
//   static const bool useTestAds = true;
//
//   // Android Test Ad Unit IDs
//   static const String androidBannerTest = 'ca-app-pub-3940256099942544/6300978111';
//   static const String androidInterstitialTest = 'ca-app-pub-3940256099942544/1033173712';
//   static const String androidRewardedTest = 'ca-app-pub-3940256099942544/5224354917';
//
//   // iOS Test Ad Unit IDs
//   static const String iosBannerTest = 'ca-app-pub-3940256099942544/2934735716';
//   static const String iosInterstitialTest = 'ca-app-pub-3940256099942544/4411468910';
//   static const String iosRewardedTest = 'ca-app-pub-3940256099942544/1712485313';
//
//   // Production Ad Unit IDs (replace with your actual IDs)
//   static const String androidBannerProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//   static const String androidInterstitialProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//   static const String androidRewardedProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//   static const String iosBannerProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//   static const String iosInterstitialProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//   static const String iosRewardedProd = 'ca-app-pub-XXXXXXX/XXXXXXX';
//
//   static bool get _isAndroid =>
//       !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
//
//   static String get bannerAdUnitId {
//     if (_isAndroid) {
//       return useTestAds ? androidBannerTest : androidBannerProd;
//     } else {
//       return useTestAds ? iosBannerTest : iosBannerProd;
//     }
//   }
//
//   static String get interstitialAdUnitId {
//     if (_isAndroid) {
//       return useTestAds ? androidInterstitialTest : androidInterstitialProd;
//     } else {
//       return useTestAds ? iosInterstitialTest : iosInterstitialProd;
//     }
//   }
//
//   static String get rewardedAdUnitId {
//     if (_isAndroid) {
//       return useTestAds ? androidRewardedTest : androidRewardedProd;
//     } else {
//       return useTestAds ? iosRewardedTest : iosRewardedProd;
//     }
//   }
// }
