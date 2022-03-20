import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kati_zero/shared/styles.dart';
import 'package:kati_zero/shared/ui_helpers.dart';
import 'package:kati_zero/viewmodels/splash_viewmodel.dart';
import 'package:spring/spring.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
        onModelReady: ((model) => model.switchScreen()),
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: appLightBlue,
              body: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                children: [
                  Container(
                    clipBehavior: Clip.none,
                    margin: EdgeInsets.only(
                      bottom: screenHeight(context) -
                          (screenHeight(context) * 0.5259),
                    ),
                    color: appDarkBlue,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      fit: StackFit.expand,
                      children: [
                        const AppTitle(),
                        Positioned(
                          bottom: -53,
                          child: Spring.fadeIn(
                              animDuration: Duration(milliseconds: 500),
                              child:
                                  Image(image: AssetImage('images/logo.png'))),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 55,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'POWERED BY',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 4,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            'TECH IDARA',
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 7.5,
                              color: appDarkBlue,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ));
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 62),
          child: Text(
            'KATI ZERO',
            style: GoogleFonts.poppins(
                letterSpacing: 10.5,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 35),
          ),
        )
      ],
    );
  }
}
