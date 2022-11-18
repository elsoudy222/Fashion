import 'package:fashion/view/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components/components.dart';
import '../../../components/constance.dart';
import '../../../data/services/shared_pref.dart';
import '../login_screen/login_screen.dart';

class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
var boardController = PageController();
class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
        image:'assets/onboarding/image1.jpg',
        title: 'Title Screen 1',
        body: 'Body Screen 1'),
    BoardingModel(
        image:'assets/onboarding/image2.jpg',
        title: 'Title Screen 2',
        body: 'Body Screen 2'),
    BoardingModel(
        image:'assets/onboarding/image3.jpg',
        title: 'Title Screen 3',
        body: 'Body Screen 3'),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value){
        navigateAndFinish(context, LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          defaultTextButton(
            text: 'SKIP',
            function: (){
              submit();
            }
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: boardController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => buildOnBoardin(boarding[index]),
                itemCount: boarding.length,
                  onPageChanged: (int index){
                    if(index == boarding.length - 1){
                      setState(() {
                        isLast = true;
                      });
                    }else{
                      isLast = false;
                    }
                  },
                ),
              ),

              Spacer(),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: AppColors.primaryColorRed,
                        dotHeight: 10,
                        dotWidth: 10,
                        spacing: 5,
                        expansionFactor: 4
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    backgroundColor: AppColors.primaryColorRed,
                    onPressed: (){
                      if(isLast){
                        setState(() {
                       submit();
                        });
                      }else{
                        boardController.nextPage(
                            duration: Duration(
                                milliseconds: 750
                            ),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },

                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }

  Widget buildOnBoardin(BoardingModel model) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          image: DecorationImage(
              image:
              AssetImage(
                  '${model.image}'
              ),
              fit: BoxFit.cover
          ),
        ),
      ),
      SizedBox(
        height: 70,
      ),
      Text(
        '${model.title}',
        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,fontSize: 30),
      ),

      Text(
        '${model.body}',
        style: GoogleFonts.abhayaLibre(fontWeight: FontWeight.bold,fontSize: 30),
      ),

    ],
  );

}
