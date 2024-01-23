import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/ui/successful.dart';
import 'package:harapanti/widgets/long_text_field.dart';
import 'package:harapanti/widgets/short_text_field.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/profile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditPantiDetail extends StatefulWidget {
  const EditPantiDetail({super.key, required this.dataPanti});

  final Panti dataPanti;

  @override
  State<EditPantiDetail> createState() {
    return _EditPantiDetailState();
  }
}

class _EditPantiDetailState extends State<EditPantiDetail> {
  bool _isLoading = false;
  late TextEditingController _pantiNameController;
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _numberOfAttendantController;
  late TextEditingController _numberOfResident;
  late TextEditingController _phoneNumber;
  late TextEditingController _pengelola;
  late TextEditingController _est;
  late TextEditingController _biography;
  late TextEditingController _description;

  File? _pickedImage;
  File? _pickedPantiImage;

  @override
  void initState() {
    super.initState();
    _pantiNameController = TextEditingController();
    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _numberOfAttendantController = TextEditingController();
    _numberOfResident = TextEditingController();
    _pengelola = TextEditingController();
    _phoneNumber = TextEditingController();
    _est = TextEditingController();
    _biography = TextEditingController();
    _description = TextEditingController();

    _pantiNameController.text = widget.dataPanti.pantiName == '-'
        ? 'Nama Panti Asuhan'
        : widget.dataPanti.pantiName;
    _cityController.text = widget.dataPanti.city == '-'
        ? 'Kota'
        : StringFormattingHelper.trimAndCapitalizeWords(widget.dataPanti.city);
    _addressController.text =
        widget.dataPanti.address == '-' ? 'Alamat' : widget.dataPanti.address;
    _numberOfAttendantController.text =
        widget.dataPanti.numberOfAttendant.toString();
    _numberOfResident.text = widget.dataPanti.numberOfResident.toString();
    _pengelola.text = widget.dataPanti.pengelola;
    _phoneNumber.text = widget.dataPanti.phoneNumber;
    _est.text = widget.dataPanti.est.toString();
    _biography.text = widget.dataPanti.biography;
    _description.text = widget.dataPanti.description;
  }

  @override
  void dispose() {
    _pantiNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _numberOfAttendantController.dispose();
    _numberOfResident.dispose();
    _pengelola.dispose();
    _phoneNumber.dispose();
    _est.dispose();
    _biography.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Edit Data Panti',
                        style: GoogleFonts.poppins(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (ctx) => const ProfilePage()),
                          );
                        },
                        icon: const Icon(
                          Icons.account_circle,
                          color: Colors.grey,
                          size: 58,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: const Color(0xFFFFE08B),
                    shadowColor: Colors.white,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 21,
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: _pickImage,
                                child: ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                      36,
                                    ), // Image radius
                                    child: _pickedImage == null
                                        ? (widget.dataPanti.imageUrl == null
                                            ? Image.asset(
                                                'assets/images/profile.png',
                                                fit: BoxFit.cover)
                                            : Image.network(
                                                widget.dataPanti.imageUrl!,
                                                fit: BoxFit.cover,
                                              ))
                                        : Image(
                                            image: FileImage(_pickedImage!),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.edit,
                                  color: Color(0xFF8A61FF),
                                  size: 25,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 21,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  controller: _pantiNameController,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF5645FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  controller: _cityController,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF5645FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                  ),
                                  controller: _addressController,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF5645FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.edit,
                            color: Color(0xFF8A61FF),
                            size: 27,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      ...widget.dataPanti.imageList.map((e) => Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox(
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 89,
                                  width: 142,
                                ),
                              ),
                            ),
                          )),
                      if (widget.dataPanti.imageList.length < 2)
                        InkWell(
                          onTap: _pickPantiImage,
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.all(0),
                            decoration: _pickedPantiImage == null
                                ? BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color: const Color(0xff8A61FF),
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  )
                                : null,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: _pickedPantiImage == null
                                  ? const SizedBox(
                                      height: 89,
                                      width: 142,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_circle,
                                            size: 41,
                                            color: Color(0xFF5645FF),
                                          ),
                                          Text(
                                            'Tambah Foto',
                                            style: TextStyle(
                                              color: Color(0xFF5645FF),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox(
                                      child: Image(
                                        image: FileImage(_pickedPantiImage!),
                                        fit: BoxFit.cover,
                                        height: 89,
                                        width: 142,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Banyak Pekerja',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _numberOfAttendantController,
                    tipeInput: TextInputType.number,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Banyak Asuhan',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _numberOfResident,
                    tipeInput: TextInputType.number,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Pengelola',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _pengelola,
                    tipeInput: TextInputType.name,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No. HP',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _phoneNumber,
                    tipeInput: TextInputType.phone,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Tahun berdiri',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _est,
                    tipeInput: TextInputType.number,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Deskripsi Singkat',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ShortTextField(
                    controller: _description,
                    tipeInput: TextInputType.name,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Biography',
                    style: GoogleFonts.poppins(
                      color: const Color(0xFF5645FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  LongTextField(
                    controller: _biography,
                    height: 180,
                    thickness: 3,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 12,
            child: _isLoading
                ? const CircularProgressIndicator()
                : IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: _onSubmit,
                    icon: const Icon(
                      Icons.save,
                      size: 60,
                      color: Color(0xFF5645FF),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  void _pickPantiImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 150,
    );

    setState(() {
      if (pickedImage == null) {
        _pickedPantiImage == null;
      } else {
        _pickedPantiImage = File(pickedImage.path);
      }
    });
  }

  void _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxWidth: 150,
    );

    setState(() {
      if (pickedImage == null) {
        _pickedImage = null;
      } else {
        _pickedImage = File(pickedImage.path);
      }
    });
  }

  void _onSubmit() async {
    FocusScope.of(context).unfocus();
    try {
      final pantiName = _pantiNameController.text.trim();
      bool checkPantiName =
          pantiName.isEmpty || pantiName == 'Nama Panti Asuhan';

      final address = _addressController.text.trim();
      bool checkAddress = address.isEmpty || address == 'Alamat';

      final city = _cityController.text.trim();
      bool checkCity = city.isEmpty || city == 'Kota';

      final attendant = int.tryParse(_numberOfAttendantController.text);
      bool checkAttendant = attendant == null || attendant < 0;

      final resident = int.tryParse(_numberOfResident.text);
      bool checkResident = resident == null || resident < 0;

      final pengelola = _pengelola.text.trim();
      bool checkPengelola = pengelola.isEmpty || pengelola == '-';

      final phoneNumber = _phoneNumber.text.trim();
      bool checkPhoneNumber = phoneNumber.isEmpty || phoneNumber == '-';

      final est = int.tryParse(_est.text);
      bool checkEst = est == null || est < 0;

      final biography = _biography.text.trim();
      bool checkBio = biography.isEmpty || biography == '-';

      final description = _description.text.trim();
      bool checkDescription = description.isEmpty || description == '-';

      final finalBool = checkPantiName ||
          checkAddress ||
          checkCity ||
          checkAttendant ||
          checkResident ||
          checkPengelola ||
          checkPhoneNumber ||
          checkEst ||
          checkBio ||
          checkDescription;

      if (finalBool ||
          (widget.dataPanti.imageUrl == null && _pickedImage == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Kesalahan format pada pengisian data!', Colors.red,
              Colors.red, Icons.info),
        );
        return;
      }
      String? newImageUrl = widget.dataPanti.imageUrl;
      String? newPantiImageUrl;

      if (_pickedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('panti_images')
            .child(widget.dataPanti.pantiID)
            .child('profile.jpg');

        await storageRef.putFile(_pickedImage!);

        newImageUrl = await storageRef.getDownloadURL();
      }

      if (_pickedPantiImage != null) {
        const uuid = Uuid();
        String newFileName = uuid.v4();
        await FirebaseStorage.instance
            .ref()
            .child('panti_image')
            .child(widget.dataPanti.pantiID)
            .child('$newFileName.jpg')
            .putFile(_pickedPantiImage!);
        newPantiImageUrl = await FirebaseStorage.instance
            .ref()
            .child('panti_image')
            .child(widget.dataPanti.pantiID)
            .child('$newFileName.jpg')
            .getDownloadURL();
      }

      Map<String, dynamic>? data;

      if (newPantiImageUrl != null) {
        data = {
          'address': address,
          'pantiName': pantiName,
          'city': city,
          'description': description,
          'numberOfAttendant': attendant,
          'numberOfResident': resident,
          'phoneNumber': phoneNumber,
          'biography': biography,
          'pengelola': pengelola,
          'est': est,
          'imageUrl': newImageUrl,
          'imageList': FieldValue.arrayUnion([newPantiImageUrl])
        };
      } else {
        data = {
          'address': address,
          'pantiName': pantiName,
          'city': city,
          'description': description,
          'numberOfAttendant': attendant,
          'numberOfResident': resident,
          'phoneNumber': phoneNumber,
          'biography': biography,
          'pengelola': pengelola,
          'est': est,
          'imageUrl': newImageUrl,
        };
      }

      await FirebaseFirestore.instance
          .collection('pantiData')
          .doc(widget.dataPanti.pantiID)
          .update(data);
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) =>
                const SuccessfulPage(msg: 'Data berhasil diupdate dikirm')));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Kesalahan format pada pengisian data!', Colors.red,
              Colors.red, Icons.info),
        );
      }
    }
  }

  SnackBar _getSnackBar(
    String message,
    Color color,
    Color borderColor,
    IconData icon,
  ) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        padding: const EdgeInsets.only(left: 9),
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19000000),
              spreadRadius: 2.0,
              blurRadius: 8.0,
              offset: Offset(2, 4),
            )
          ],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Icon(icon, color: Colors.white),
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(message,
                          style: const TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              icon: const Icon(Icons.close, color: Colors.white),
            )
          ],
        ),
      ),
    );
    return snackBar;
  }
}
