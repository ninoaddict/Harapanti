import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

final dio = Dio();

class ApplicantCard extends StatefulWidget {
  const ApplicantCard({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<StatefulWidget> createState() {
    return _ApplicantCardState();
  }
}

class _ApplicantCardState extends State<ApplicantCard> {
  late String _localPath;
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

  Future<bool> _checkPermission() async {
    if (platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    // print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
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
                      child: widget.data['imageUrl'] == null
                          ? Image.asset('assets/images/profile.png',
                              fit: BoxFit.cover)
                          : Image.network(
                              widget.data['imageUrl'],
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
                          widget.data['name'],
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
                          widget.data['email'],
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
                          widget.data['homeAddress'],
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
                    _permissionReady = await _checkPermission();
                    if (_permissionReady) {
                      await _prepareSaveDir();
                      // print("Downloading");
                      try {
                        await dio.download(widget.data['pdfUrl'],
                            "$_localPath/${widget.data['name'].toString().replaceAll(' ', '')}.pdf");
                        // print("Download Completed.");
                      } catch (e) {
                        // print("Download Failed.\n\n" + e.toString());
                      }
                    }
                  },
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
