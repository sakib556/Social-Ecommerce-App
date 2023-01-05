import 'package:flutter/material.dart';
import 'package:protibeshi_app/models/offer/offer.dart';
import 'package:protibeshi_app/themes/images.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeGeneratorScreen extends StatelessWidget {
  const QrCodeGeneratorScreen({Key? key, required this.offer}) : super(key: key);
  final OfferModel offer;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
        centerTitle: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Image.asset(MyImages.logo),
        ),
       
      ),
        body: Center(
          child: QrImage(
            data: offer.id,
            version: QrVersions.auto,
            size: 180,
            gapless: false,
          )
        ),
      ),
    );
  }
}
