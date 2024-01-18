import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/ui/profile.dart';
import 'package:harapanti/utils/string_formatting_helper.dart';
import 'package:harapanti/widgets/loading.dart';
import 'package:harapanti/widgets/long_text_field.dart';
import 'package:harapanti/widgets/openvacancy_list.dart';
import 'package:harapanti/widgets/search_field.dart';
import 'package:harapanti/widgets/short_text_field.dart';
import 'package:harapanti/widgets/vacancy_list.dart';

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
  bool _isSubmitting = false;
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
                                const Icon(
                                  Icons.account_circle,
                                  color: Colors.black54,
                                  size: 72,
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
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox(
                                  child: Image.asset(
                                    'assets/images/dummy_panti.png',
                                    fit: BoxFit.cover,
                                    height: 89,
                                    width: 142,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: const Color(0xff8A61FF),
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: const SizedBox(
                                  height: 89,
                                  width: 142,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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

  void _onSubmit() async {
    FocusScope.of(context).unfocus();
    try {
      final pantiName = _pantiNameController.text;
      bool checkPantiName = pantiName.trim().isEmpty;

      final address = _addressController.text;
      bool checkAddress = address.trim().isEmpty;

      final city = _cityController.text;
      bool checkCity = city.trim().isEmpty;

      final attendant = int.tryParse(_numberOfAttendantController.text);
      bool checkAttendant = attendant == null || attendant < 0;

      final resident = int.tryParse(_numberOfResident.text);
      bool checkResident = resident == null || resident < 0;

      final pengelola = _pengelola.text;
      bool checkPengelola = pengelola.trim().isEmpty;

      final phoneNumber = _phoneNumber.text;
      bool checkPhoneNumber = phoneNumber.trim().isEmpty;

      final est = int.tryParse(_est.text);
      bool checkEst = est == null || est < 0;

      final biography = _biography.text;
      bool checkBio = biography.trim().isEmpty;

      final description = _description.text;
      bool checkDescription = description.trim().isEmpty;

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

      if (finalBool) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Kesalahan format pada pengisian data!', Colors.red,
              Colors.red, Icons.info),
        );
        return;
      }

      final Map<String, dynamic> data = {
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
      };

      await FirebaseFirestore.instance
          .collection('pantiData')
          .doc(_pantiId)
          .update(data)
          .onError(
        (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            _getSnackBar('Kesalahan format pada pengisian data!', Colors.red,
                Colors.red, Icons.info),
          );
          return;
        },
      ).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          _getSnackBar('Data berhasil diunggah', Colors.green, Colors.green,
              Icons.check),
        );
      });
    } catch (error) {
      if (context.mounted) {
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
