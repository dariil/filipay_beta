import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'mainPage.dart';
import '../widgets/components.dart';
import '../functions/functions.dart';
import 'qrPay.dart';

class QRCam extends StatefulWidget {
  const QRCam({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRCamState();
}

class _QRCamState extends State<QRCam> {
  pageFunctions mode = pageFunctions();

  pageComponents myComponents = pageComponents();
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool generateQR = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xff00adee),
        centerTitle: true,
        title: Text(
          "${mode.transportMode}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildQrView(context),
            Container(
              margin: EdgeInsets.only(top: 30.0),
              width: double.infinity,
              child: Text(
                "Make sure the QR code is within the frame.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: controller?.getFlashStatus(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == true) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(Icons.flash_on, size: 30),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.flash_off, size: 30),
                                    );
                                  },
                                ),
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Flash")),
                              ],
                            )),
                      ),
                      Container(
                        width: 190.0,
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            onPressed: () {
                              myComponents.generateQR(
                                context,
                              );
                            },
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: controller?.getCameraInfo(),
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.qr_code, size: 30),
                                    );
                                  },
                                ),
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Generate QR Code")),
                              ],
                            )),
                      ),
                      Container(
                        width: 150.0,
                        height: 70.0,
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                            ),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: controller?.getCameraInfo(),
                                  builder: (context, snapshot) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(Icons.cameraswitch_sharp,
                                          size: 30),
                                    );
                                  },
                                ),
                                FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text("Switch Camera"))
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 200.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          overlayColor: Color.fromRGBO(44, 179, 231, 0.7),
          borderColor: Color.fromRGBO(0, 51, 102, 1.0),
          borderRadius: 10,
          borderLength: 40,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => qrPay(),
            ),
          );
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
