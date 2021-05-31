import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SignaturePagePreview extends StatelessWidget {
  final Uint8List signature;

  const SignaturePagePreview({
    Key key,
    @required this.signature,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text('Store Signature'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              //to store signature everytime button is pressed
              storeSignature(context);
            },
          ),
        ],
      ),
      body: Center(
        child: Image(
          width: 600,
          height: 600,
          image: MemoryImage(signature),
        ),
      ),
    );
  }

/*  To store image first of all we need to get stoarge permission. So we request storage permission
    ***************************************************************************
    Note: To make use of permission we have permission handler package and to
    access gallery we have image gallery saver. 
   - First we add package in dependencies of pubspec.yaml file.
   - Second we go to android->app->src->main->AndroidManifest.xml and add
     <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/> 
     above applicaton and add 
     android:requestLegacyExternalStorage="true" on application tag
 
 */
  Future storeSignature(BuildContext context) async {
    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    final time = DateTime.now().toIso8601String().replaceAll(',', ':');
    /* where we want to store signature. Inlcuding 
        datetime for now to make unique signature name and store multiple image. 
        */
    final name = 'signature._$time.png';

    final result = await ImageGallerySaver.saveImage(signature, name: name);
    // for now saving in local file later can also put these bytes to server

    final isSuccess = result['isSucess'];

    // if successfull show added and returns to the digital signature page. if not shows failed
    if (isSuccess == isSuccess) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('added'),
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('failed'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }
}
