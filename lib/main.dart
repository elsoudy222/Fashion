import 'package:fashion/data/services/observer.dart';
import 'package:fashion/data/services/shared_pref.dart';
import 'package:fashion/view/const/colors.dart';
import 'package:fashion/view/screens/layout_screen/layout_screen.dart';
import 'package:fashion/view/screens/login_screen/login_screen.dart';
import 'package:fashion/view/screens/on_boarding/onboarding_screen.dart';
import 'package:fashion/view_model/layout/layout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'components/constance.dart';
import 'data/services/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  DioHelper.init();
  Widget widget;

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  print(token);

  if (onBoarding != null) {
    if (token != null)
      widget = LayoutScreen();
    else
      widget = LoginScreen();
  }
  else {
    widget = OnBoardingScreen();
  }


  BlocOverrides.runZoned(
        () {
      runApp(MyApp(startWidget: widget,));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({Key? key, required this.startWidget,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LayoutCubit()..getHomeData()..getCategories()..getFavorites()..getCarts(),
        ),
      ],
      child: BlocConsumer<LayoutCubit, LayoutState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fashion App',
            theme: ThemeData(
              primaryColor: AppColors.primaryColorRed,
              appBarTheme: AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(
                    color: Colors.black
                ),
               // titleTextStyle: GoogleFonts.atkinsonHyperlegible(fontWeight: FontWeight.bold,fontSize: 30,color: Colors.black),
              ),
            ),
            home: startWidget,
            // routes: {
            //   '/': (ctx) => const LoginScreen(),
            //
            // },
          );
        },
      ),
    );
  }
}
