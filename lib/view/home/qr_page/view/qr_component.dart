import 'package:flutter/material.dart';
import '../../../../core/components/appbar/transparent_app_bar.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../convert_page/view/convert_page.dart';
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
      appBar: const TransparentAppBar(),
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
            builder: (context) => const ConvertPage(),
          ),
        );
      });
    });
  }
}
