import 'package:flutter/material.dart';
import 'package:hackathon_app/core/extensions/context_extension.dart';
import 'package:hackathon_app/view/home/convert_page/view/convert_page.dart';
import 'package:hackathon_app/view/home/convert_page/viewmodel/convert_page_viewmodel.dart';
import 'package:provider/provider.dart';
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
      backgroundColor: context.themeColor.primary,
      body: SafeArea(
        child: _QRBody(),
      ),
    );
  }

  QRView _QRBody() {
    return QRView(
      key: qrKey,
      overlay: QrScannerOverlayShape(),
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: const [BarcodeFormat.qrcode],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConvertPage(id: result!.code!),
          ),
        );
      });
    });
  }
}
