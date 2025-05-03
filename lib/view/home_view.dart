import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_code/const/image_strings.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import '../common/widget/round_button.dart';
import '../controller/image_controller.dart';
import '../controller/text_controller.dart';
import '../style/color.dart';
import '../style/text_style.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  QRViewController? _qrViewController;
  final TextEditingController _textController = TextEditingController();
  final MobileScannerController controllerScanner = MobileScannerController();
  final TextEditingController _simController = TextEditingController();
  final TextController controller = Get.put(TextController());
  final UploadController imageController = Get.put(UploadController());

  @override
  void initState() {
    super.initState();
    controller.detectedText.listen((value) {
      _simController.text = value;
    });
  }

  @override
  void dispose() {
    _qrViewController?.dispose();
    _textController.dispose();
    _simController.dispose();
    super.dispose();
  }

  void _toggleFlash() async {
    if (_qrViewController != null) {
      await _qrViewController?.toggleFlash();
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Scan SIM Number",
              style: AppTextStyles.kCaption13SemiBoldTextStyle
                  .copyWith(color: AppColors.white),
            ),
          ),
          actions: [
            IconButton(onPressed: _toggleFlash, icon: Icon(Icons.flash_auto)),
          ],
        ),
        body: Obx(() => Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        width: 370,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: QRView(
                          key: GlobalKey(debugLabel: 'QR'),
                          onQRViewCreated:
                              (QRViewController controller) {
                            _qrViewController = controller;
                            _qrViewController?.resumeCamera();
                            _qrViewController?.scannedDataStream
                                .listen((scanData) async {
                              if (scanData != null &&
                                  scanData.code != null) {
                                String scannedCode = scanData.code ?? '';
                                if (scannedCode.length > 25) {
                                  scannedCode =
                                      scannedCode.substring(0, 35);
                                }
                                setState(() {
                                  _textController.text = scannedCode;
                                });
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      RoundButton(
                        title: 'Scan Airtel SIM',
                        onTap: () async {
                          try {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              await controller.detectTextFromImage(
                                  File(pickedFile.path));
                            }
                          } catch (e) {
                            Get.snackbar('Error',
                                'Failed to scan image: ${e.toString()}');
                          }
                        },
                      ),
                      RoundButton(
                        title: 'Scan Other SIM',
                        onTap: () async {
                          try {
                            final picker = ImagePicker();
                            final pickedFile = await picker.pickImage(
                                source: ImageSource.camera);
                            if (pickedFile != null) {
                              await controller.detectTextFromImageOther(
                                  File(pickedFile.path));
                            }
                          } catch (e) {
                            Get.snackbar('Error',
                                'Failed to scan image: ${e.toString()}');
                          }
                        },
                      ),
                      _infoBox(_simController),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: "Enter your serial number",
                            hintStyle:
                            TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      RoundButton(
                          title: "Take photo of SIM",
                          onTap: imageController.pickImageFromCamera),
                      imageController.selectedImages.isNotEmpty
                          ? SizedBox(
                        height: 200,
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: imageController
                              .selectedImages.length,
                          itemBuilder: (context, index) {
                            final File image = imageController
                                .selectedImages[index];
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Image.file(image,
                                      fit: BoxFit.cover),
                                ),
                                Positioned(
                                  left: 3,
                                  bottom: 5,
                                  child: GestureDetector(
                                    onTap: () => imageController
                                        .removeImage(image),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 15,
                                      child: Icon(
                                        Icons.cancel,
                                        size: 27,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                          : Center(child: Image.asset(noData1)),
                      RoundButton(
                        title: 'Submit',
                        onTap: () {
                          final sim = _simController.text.trim();
                          final serial = _textController.text.trim();
                          if (sim.isEmpty || serial.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "SIM or Serial number is missing",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            imageController.uploadSimData(
                                simNo: sim, serial: serial);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            if (imageController.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        )),
      ),
    );
  }


  Widget _infoBox(TextEditingController controller) {
    return Container(
      width: 380,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        maxLines: null,
        decoration: InputDecoration.collapsed(
          hintText: "Enter SIM number",
        ),
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
