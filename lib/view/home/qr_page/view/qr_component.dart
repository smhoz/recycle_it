import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRPage extends StatefulWidget {
  final Function(QRViewController)? onQRCreate;
  const QRPage({Key? key, this.onQRCreate}) : super(key: key);

  @override
  _QRPageState createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  Barcode? result;

  @override
  void dispose() {
    super.dispose();
    controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scan")),
      body: QRView(
        key: qrKey,
        overlay: QrScannerOverlayShape(),
        onQRViewCreated: _onQRViewCreated,
        formatsAllowed: const [BarcodeFormat.qrcode],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Navigator.pop(context);
        //TODO: Navigate to ConvertPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(child: Text(result!.code!)),
            ),
          ),
        );
      });
    });
  }
}
