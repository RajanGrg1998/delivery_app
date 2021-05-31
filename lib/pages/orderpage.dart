import 'package:deliveryboy_app/digital_signature_screen/signaturescreen.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(46),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(13),
              offset: Offset(0, 3.0),
              blurRadius: 6,
            )
          ]),
          child: AppBar(
            title: Center(
              child: Text(
                'Digital Signature',
                style: TextStyle(
                  fontFamily: 'Roboto-Medium',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SignatureScreen(),
    );
  }
}
