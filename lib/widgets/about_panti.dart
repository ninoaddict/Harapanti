import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/models/panti_model.dart';
import 'package:harapanti/provider/panti_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutPanti extends ConsumerWidget {
  const AboutPanti({super.key, required this.pantiID});

  final String pantiID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Panti> singlePantiData =
        ref.watch(SinglePantiProvider(pantiID));

    Widget pantiCard(Panti dataPanti) {
      return InkWell(
        onTap: () {},
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/images/dummy.png'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataPanti.pantiName,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      '${dataPanti.numberOfResident} Anak Asuh . ${dataPanti.numberOfAttendant} Pekerja Sosial',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      dataPanti.description,
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Dikelola oleh ${dataPanti.pengelola}',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    return switch (singlePantiData) {
      AsyncData(:final value) => pantiCard(value),
      AsyncError() => Card(
          margin: const EdgeInsets.only(
            bottom: 12,
            top: 0,
            left: 0,
            right: 0,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: const SizedBox(
            height: 98,
            child: Center(
              child: Text('Oops, failed to fetch data!'),
            ),
          ),
        ),
      _ => Card(
          margin: const EdgeInsets.only(
            bottom: 12,
            top: 0,
            left: 0,
            right: 0,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          child: const SizedBox(
            height: 98,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
    };
  }
}
