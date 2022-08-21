import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_admin/views/log_in.dart';
import 'package:top_admin/views/nurses.dart';
import 'package:top_admin/views/page_selector.dart';

import 'controllers/user_controler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) => MultiProvider(
        providers: [
          Provider<UserController>(create: (_) => UserController()),
          // ChangeNotifierProvider<AvailabilityController>(create: (_) => AvailabilityController()),
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
          home: PageSelector(),
        ),
      ),
    );
  }
}

