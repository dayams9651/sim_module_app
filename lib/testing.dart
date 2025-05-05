// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
//
// class BarcodeScannerPage extends StatefulWidget {
//   @override
//   _BarcodeScannerPageState createState() => _BarcodeScannerPageState();
// }
//
// class _BarcodeScannerPageState extends State<BarcodeScannerPage> {
//   late CameraController _cameraController;
//   late BarcodeScanner _barcodeScanner;
//   bool _isDetecting = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//     _barcodeScanner = BarcodeScanner();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final camera = cameras.firstWhere(
//             (cam) => cam.lensDirection == CameraLensDirection.back);
//
//     _cameraController = CameraController(camera, ResolutionPreset.medium);
//     await _cameraController.initialize();
//     await _cameraController.startImageStream(_processCameraImage);
//     setState(() {});
//   }
//
//   void _processCameraImage(CameraImage image) async {
//     if (_isDetecting) return;
//     _isDetecting = true;
//
//     final WriteBuffer allBytes = WriteBuffer();
//     for (final plane in image.planes) {
//       allBytes.putUint8List(plane.bytes);
//     }
//
//     final bytes = allBytes.done().buffer.asUint8List();
//     final Size imageSize =
//     Size(image.width.toDouble(), image.height.toDouble());
//
//     final InputImageRotation rotation =
//         InputImageRotation.rotation0deg; // adjust as needed
//
//     final InputImageFormat format =
//         InputImageFormatMethods.fromRawValue(image.format.raw) ??
//             InputImageFormat.nv21;
//
//     final planeData = image.planes.map(
//           (plane) => InputImagePlaneMetadata(
//         bytesPerRow: plane.bytesPerRow,
//         height: plane.height,
//         width: plane.width,
//       ),
//     ).toList();
//
//     final inputImageData = InputImageData(
//       size: imageSize,
//       imageRotation: rotation,
//       inputImageFormat: format,
//       planeData: planeData,
//     );
//
//     final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
//
//     final barcodes = await _barcodeScanner.processImage(inputImage);
//
//     if (barcodes.isNotEmpty) {
//       for (final barcode in barcodes) {
//         print('Barcode found! Type: ${barcode.type}, Value: ${barcode.rawValue}');
//       }
//     }
//
//     _isDetecting = false;
//   }
//
//   @override
//   void dispose() {
//     _cameraController.dispose();
//     _barcodeScanner.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_cameraController.value.isInitialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     return Scaffold(
//       body: CameraPreview(_cameraController),
//     );
//   }
// }
