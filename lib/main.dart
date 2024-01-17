import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:harapanti/intermediete.dart';
import 'package:harapanti/ui/auth/auth.dart';
import 'package:harapanti/ui/personal/home.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harapanti/ui/organization/adminhome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ProviderScope(child: App()),
  );
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harapanti',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xff8a61ff),
          onPrimary: Color(0xfff4f4f4),
          secondary: Color(0xff5645ff),
          onSecondary: Color(0xffffe088),
          error: Colors.red,
          onError: Colors.orange,
          background: Color(0xfff4f4f4),
          onBackground: Color(0xffd2d1d1),
          surface: Color(0xff7a7979),
          onSurface: Color(0xff434242),
          tertiary: Color(0xff292929),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('Loading...'),
            );
          }

          if (snapshot.hasData) {
            return const IntermedietePage();
          }

          return const AuthPage();
        },
      ),
    );
  }
}
