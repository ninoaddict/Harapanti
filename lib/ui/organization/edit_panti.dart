import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/ui/profile.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/long_text_field.dart';
import 'package:harapanti/widgets/short_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

final db = FirebaseFirestore.instance;

class EditPantiPage extends StatefulWidget {
  const EditPantiPage({super.key});

  @override
  State<EditPantiPage> createState() {
    return _EditPantiPageState();
  }
}

class _EditPantiPageState extends State<EditPantiPage> {
  bool _isLoading = true;
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
  late Panti dataPanti;
  late String _pantiId;

  File? _pickedImage;
  File? _pickedPantiImage;

  void getUsername() async {
    final user = FirebaseAuth.instance.currentUser!;
    final pantiResp = await FirebaseFirestore.instance
        .collection('pantiData')
        .where('userID', isEqualTo: user.uid)
        .get();
    _pantiId = pantiResp.docs[0].id;

    final Map<String, dynamic> pp = pantiResp.docs[0].data();
    dataPanti = Panti(
      pantiName: pp['pantiName'],
      city: pp['city'],
      description: pp['description'],
      numberOfAttendant: pp['numberOfAttendant'],
      numberOfResident: pp['numberOfResident'],
      phoneNumber: pp['phoneNumber'],
      biography: pp['biography'],
      address: pp['address'],
      pengelola: pp['pengelola'],
      est: pp['est'],
      imageUrl: pp['imageUrl'],
      imageList: pp['imageList'],
    );

    _pantiNameController.text =
        dataPanti.pantiName == '-' ? 'Nama Panti Asuhan' : dataPanti.pantiName;
    _cityController.text = dataPanti.city == '-'
        ? 'Kota'
        : StringFormattingHelper.trimAndCapitalizeWords(dataPanti.city);
    _addressController.text =
        dataPanti.address == '-' ? 'Alamat' : dataPanti.address;
    _numberOfAttendantController.text = dataPanti.numberOfAttendant.toString();
    _numberOfResident.text = dataPanti.numberOfResident.toString();
    _pengelola.text = dataPanti.pengelola;
    _phoneNumber.text = dataPanti.phoneNumber;
    _est.text = dataPanti.est.toString();
    _biography.text = dataPanti.biography;
    _description.text = dataPanti.description;

    setState(() {
      _isLoading = false;
    });
  }

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
    getUsername();
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
    return _isLoading
        ? const LoadingPage()
        : SafeArea(
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
                              // dataPanti.pantiName,
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
                                              ? (dataPanti.imageUrl == null
                                                  ? Image.asset(
                                                      'assets/images/profile.png',
                                                      fit: BoxFit.cover)
                                                  : Image.network(
                                                      dataPanti.imageUrl!,
                                                      fit: BoxFit.cover,
                                                    ))
                                              : Image(
                                                  image:
                                                      FileImage(_pickedImage!),
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
                            ...dataPanti.imageList.map((e) => Container(
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
                            if (dataPanti.imageList.length < 2)
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
                                          borderRadius:
                                              BorderRadius.circular(20),
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
                                              image:
                                                  FileImage(_pickedPantiImage!),
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
      bool checkDescription = description.isEmpty == '-';

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

      if (finalBool || (dataPanti.imageUrl == null && _pickedImage == null)) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Kesalahan format pada pengisian data!', Colors.red,
              Colors.red, Icons.info),
        );
        return;
      }
      String? newImageUrl = dataPanti.imageUrl;
      String? newPantiImageUrl;

      // Map<String, dynamic>? data;

      if (_pickedImage != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('panti_images')
            .child(_pantiId)
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
            .child(_pantiId)
            .child('$newFileName.jpg')
            .putFile(_pickedPantiImage!);
        newPantiImageUrl = await FirebaseStorage.instance
            .ref()
            .child('panti_image')
            .child(_pantiId)
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
          .doc(_pantiId)
          .update(data)
          .then(
        (value) {
          ScaffoldMessenger.of(context).showSnackBar(
            _getSnackBar('Data berhasil diunggah', Colors.green, Colors.green,
                Icons.check),
          );
        },
      );
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
