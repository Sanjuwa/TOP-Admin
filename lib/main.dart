import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/controllers/job_controller.dart';
import 'package:top_admin/controllers/role_controller.dart';
import 'package:top_admin/controllers/user_controller.dart';
import 'package:top_admin/firebase_options.dart';
import 'package:top_admin/wrapper.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) => MultiProvider(
        providers: [
          Provider<UserController>(create: (_) => UserController()),
          ChangeNotifierProvider<JobController>(create: (_) => JobController()),
          ChangeNotifierProvider<RoleController>(create: (_) => RoleController()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            textTheme: GoogleFonts.outfitTextTheme(),
            // primaryColor: kBackgroundColor,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              // backgroundColor: kBackgroundColor,
              elevation: 0,
              titleTextStyle: GoogleFonts.sourceSansPro(
                color: Colors.white,
                fontSize: 35.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}

