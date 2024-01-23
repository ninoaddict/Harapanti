import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/application_model.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

final dio = Dio();

class ApplicantCard extends StatefulWidget {
  const ApplicantCard({super.key, required this.appData});
  // final Map<String, dynamic> data;
  final Application appData;

  @override
  State<StatefulWidget> createState() {
    return _ApplicantCardState();
  }
}

class _ApplicantCardState extends State<ApplicantCard> {
  late bool _permissionReady;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  // Future<bool> _checkPermission() async {
  //   if (platform == TargetPlatform.android) {
  //     final status = await Permission.storage.status;
  //     if (status != PermissionStatus.granted) {
  //       final result = await Permission.storage.request();
  //       if (result == PermissionStatus.granted) {
  //         return true;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<void> _prepareSaveDir() async {
  //   _localPath = (await _findLocalPath())!;

  //   // print(_localPath);
  //   final savedDir = Directory(_localPath);
  //   bool hasExisted = await savedDir.exists();
  //   if (!hasExisted) {
  //     savedDir.create();
  //   }
  // }

  // Future<String?> _findLocalPath() async {
  //   if (platform == TargetPlatform.android) {
  //     return "/storage/emulated/0/Download";
  //   } else {
  //     var directory = await getApplicationDocumentsDirectory();
  //     return '${directory.path}${Platform.pathSeparator}Download';
  //   }
  // }

  Future<void> savePdfFile() async {
    final String fileName =
        StringFormattingHelper.formatCityName(widget.appData.name);

    if (Platform.isAndroid) {
      var status = await Permission.storage.status;

      if (status.isGranted) {
        try {
          final appDocumentsDirectory =
              await getApplicationDocumentsDirectory();
          final filePath = '${appDocumentsDirectory.path}/$fileName.pdf';

          await dio.download(widget.appData.pdfUrl, filePath);

          print("Download Completed. File saved to: $filePath");
        } catch (e) {
          print("Download Failed.\n\n" + e.toString());
        }
      } else {
        if (status.isPermanentlyDenied) {
          // Open the app settings to allow the user to grant the permission manually.
          openAppSettings();
        } else {
          // Request the storage permission.
          status = await Permission.storage.request();
          if (status.isGranted) {
            // Retry the download after the permission is granted.
            await savePdfFile();
          } else {
            print('Permission denied');
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 2,
            color: Color(0xFF8A61FF),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(
                        45,
                      ), // Image radius
                      child: widget.appData.imageUrl == null
                          ? Image.asset('assets/images/profile.png',
                              fit: BoxFit.cover)
                          : Image.network(
                              widget.appData.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Nama Lengkap',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          widget.appData.name,
                          style: GoogleFonts.poppins(
                            color: const Color(0xff292929),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Alamat Email',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          widget.appData.email,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292929),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Alamat Rumah',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(
                      bottom: 12, top: 4, left: 0, right: 0),
                  color: Colors.white,
                  shadowColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Color(0xFF8A61FF),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        Text(
                          widget.appData.homeAddress,
                          style: GoogleFonts.poppins(
                              color: const Color(0xff292929),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Resume',
                  style: GoogleFonts.poppins(
                    color: const Color(0xff292929),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await savePdfFile();
                  },
                  splashColor: Colors.white,
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  highlightColor: Colors.white,
                  child: Card(
                    margin: const EdgeInsets.only(
                        bottom: 55, top: 4, left: 0, right: 0),
                    color: Colors.white,
                    shadowColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: Color(0xFF8A61FF),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      child: Row(
                        children: [
                          Text(
                            'resume.pdf',
                            style: GoogleFonts.poppins(
                                color: const Color(0xff292929),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
