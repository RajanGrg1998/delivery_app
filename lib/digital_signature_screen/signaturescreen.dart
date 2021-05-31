import 'dart:io';
import 'dart:typed_data';

import 'package:deliveryboy_app/digital_signature_screen/signaturepagepreview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  SignatureController controller;
  File _image;

  //creating fuction to get image from camera.
  _imageFromGallery() async {
    PickedFile image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 58);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = SignatureController(
      penColor: Colors.black,
      // penStrokeWidth: 5,
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(38, 20, 37, 33),
        //margin: EdgeInsets.symmetric(vertical: 20, horizontal: 75),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              alignment: Alignment.topLeft,
              child: Text(
                'Signature',
                style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Signature(
                  controller: controller,
                  height: 200,
                  // width: 900,
                  width: size.width / 1,
                  backgroundColor: Colors.white),
            ),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 8, bottom: 18.5),
              child: TextButton(
                child: Text(
                  'Clear',
                  style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 14,
                    color: Color(0xffFE0007),
                  ),
                ),
                onPressed: () {
                  controller.clear();
                },
              ),
            ),
            Stack(
              children: [
                Divider(),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "OR",
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffD7D7D7),
                onPrimary: Colors.black,
                minimumSize: Size(300, 40),
                padding: EdgeInsets.all(15),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      //defining size of the dialog box
                      child: Container(
                        width: double.infinity,
                        height: 320,
                        padding: EdgeInsets.all(2),
                        child: Column(
                          children: [
                            //container for image to display
                            Container(
                              width: double.infinity,
                              height: 250,
                              color: Colors.black26,
                              child: _image != null
                                  ? Image.file(_image, fit: BoxFit.cover)
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.camera_alt_outlined),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text('No Image Selected'),
                                      ],
                                    ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.photo_filter,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    //implementing above _imageFromGallery funcyionality in app body
                                    _imageFromGallery();
                                    Navigator.of(context).pop();
                                  },
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.done,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    print('Image submitted');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Choose Photo',
                style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                onPrimary: Colors.white,
                minimumSize: Size(300, 40),
                padding: EdgeInsets.all(15),
              ),
              onPressed: () async {
                // to check if signature is empty or not. if not empty it is exported
                if (controller.isNotEmpty) {
                  final signature = await exportSignature();

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SignaturePagePreview(
                        signature: signature,
                      ), // puting signature bytes inside which was exported before
                    ),
                  );
                }
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  fontFamily: 'Roboto-Regular',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //to export signature. Creating new SignatureController called exportController
  Future<Uint8List> exportSignature() async {
    final exportController = SignatureController(
      //defines how signature looks while exported
      penStrokeWidth: 4,
      exportBackgroundColor: Colors.white,
      points: controller
          .points, // list of points of signature .i.e. all the lines that were drwan on the signature pad
    );
    final signature =
        await exportController.toPngBytes(); //exporting signature to png
    exportController.dispose(); // to clean everything up again
    return signature;
  }
}
