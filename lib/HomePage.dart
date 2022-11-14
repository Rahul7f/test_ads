import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:webviewx/webviewx.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late BannerAd _bannerAd;
  bool _isAdLoaded = false;
  late WebViewXController webviewController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBanner();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/1033173712',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
          },
        ));
  }

  void initBanner() {
    _bannerAd = BannerAd(
        size: AdSize.mediumRectangle,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {

              _isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            Fluttertoast.showToast(msg: "Fail to load");
    
          },
        ),
        request: const AdRequest()
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          adsenseAdsView(),
        ],
      )

    );
  }

  Widget adsenseAdsView() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'adViewType',
            (int viewID) => IFrameElement()
          ..width = '320'
          ..height = '100'
          ..src = '<script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-3304351919932474"crossorigin="anonymous"></script> <!-- test --> <ins class="adsbygoogle"style="display:block"data-ad-client="ca-pub-3304351919932474"data-ad-slot="5522124761"data-ad-format="auto"data-full-width-responsive="true"></ins><script>(adsbygoogle = window.adsbygoogle || []).push({});</script>'
          ..style.border = 'none');

    return SizedBox(
      height: 100.0,
      width: 320.0,
      child: HtmlElementView(
        viewType: 'adViewType',
      ),
    );
  }



}

class Iframe extends StatelessWidget {
  Iframe() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('iframe', (int viewId) {
      var iframe = IFrameElement();
      iframe.src = 'http://www.africau.edu/';
      return iframe;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 500, height: 500, child: HtmlElementView(viewType: 'iframe'));
  }
}
