import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
  final TextEditingController serialController = TextEditingController();
  final MobileScannerController controllerScanner = MobileScannerController();
  final TextEditingController simController = TextEditingController();
  final TextController controller = Get.put(TextController());
  final UploadController imageController = Get.put(UploadController());
  bool isAirtelSelected = false;
  bool isJioSelected = false;
  bool isViSelected = false;
  File? capturedImage;

  @override
  void initState() {
    super.initState();
    controller.detectedText.listen((value) {
      simController.text = value;
    });
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

  void _onSimTypeSelected(String simType) {
    setState(() {
      isAirtelSelected = simType == 'Airtel';
      isJioSelected = simType == 'Jio';
      isViSelected = simType == 'Vodafone';
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
                          onQRViewCreated: (QRViewController controller) {
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
                                  serialController.text = scannedCode;
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
                            final pickedFile = await picker.pickImage(source: ImageSource.camera);
                            if (pickedFile != null) {
                              setState(() {
                                capturedImage = File(pickedFile.path);
                              });
                              await controller.detectTextFromImage(File(pickedFile.path));
                            }
                          } catch (e) {
                            Get.snackbar('Error', 'Failed to scan image: ${e.toString()}');
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
                              setState(() {
                                capturedImage = File(pickedFile.path);
                              });
                              await controller.detectTextFromImageOther(
                                  File(pickedFile.path));
                            }
                          } catch (e) {
                            Get.snackbar('Error',
                                'Failed to scan image: ${e.toString()}');
                          }
                        },
                      ),
                      _infoBox(simController),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: serialController,
                          decoration: InputDecoration(
                            hintText: "Enter your serial number",
                            hintStyle:
                            TextStyle(fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isAirtelSelected,
                                onChanged: (value) {
                                  _onSimTypeSelected('Airtel');
                                },
                              ),
                              const Text("Airtel"),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              Checkbox(
                                value: isJioSelected,
                                onChanged: (value) {
                                  _onSimTypeSelected('Jio');
                                },
                              ),
                              const Text("Jio"),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: isViSelected,
                                onChanged: (value) {
                                  _onSimTypeSelected('Vodafone');
                                },
                              ),
                              const Text("Vodafone"),
                            ],
                          ),
                        ],
                      ),

                      capturedImage != null
                          ? Image.file(
                        capturedImage!,
                        height: 150,
                        width: 230,
                        fit: BoxFit.cover,
                      )
                          : Center(child: Text('No image selected')),

                      // RoundButton(
                      //   title: 'Submit',
                      //   onTap: () {
                      //     final sim = simController.text.trim();
                      //     final serial = serialController.text.trim();
                      //     if (sim.isEmpty || serial.isEmpty) {
                      //       Get.snackbar(
                      //         "Error",
                      //         "SIM or Serial number is missing",
                      //         backgroundColor: Colors.red,
                      //         colorText: Colors.white,
                      //       );
                      //     } else {
                      //       imageController.uploadSimData(
                      //         simNo: sim,
                      //         serial: serial,
                      //         imageFile: capturedImage,
                      //         simController: simController,
                      //         serialController: serialController,
                      //         simType: '',
                      //       );
                      //     }
                      //   },
                      // ),
                      RoundButton(
                        title: 'Submit',
                        onTap: () {
                          final sim = simController.text.trim();
                          final serial = serialController.text.trim();
                          String selectedSimType = '';

                          if (isAirtelSelected) {
                            selectedSimType = 'Airtel';
                          } else if (isJioSelected) {
                            selectedSimType = 'Jio';
                          } else if (isViSelected) {
                            selectedSimType = 'Vodafone';
                          }

                          if (sim.isEmpty || serial.isEmpty || selectedSimType.isEmpty) {
                            Get.snackbar(
                              "Error",
                              "SIM, Serial number, or SIM type is missing",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          } else {
                            imageController.uploadSimData(
                              simNo: sim,
                              serial: serial,
                              imageFile: capturedImage,
                              simController: simController,
                              serialController: serialController,
                              simType: selectedSimType,
                            );
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