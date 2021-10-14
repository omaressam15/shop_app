import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Dio/sherd_prefrens.dart';
import 'package:shop_app/LoginScreen/login_screen.dart';
import 'package:shop_app/components.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel{

  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body});
}

class OnBordScreen extends StatefulWidget {


  const OnBordScreen({key}) : super(key: key);

  @override
  _OnBordScreenState createState() => _OnBordScreenState();
}



class _OnBordScreenState extends State<OnBordScreen> {

  var boardController = PageController();

  bool isLast = false;

  bool onBoarding = false;

  void submit(){

    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {

      if(value){

        navigateNoBack(LoginScreen(), context);

      }


    });

  }


  List<BoardingModel> boarding = [

    BoardingModel(
      title:'on Board 1 Title',
      image: 'assets/images/onboard_1.jpg',
      body:'on Board 1 Body'
    ),

     BoardingModel(
      title:'on Board 2 Title',
      image: 'assets/images/onboard_1.jpg',
      body:'on Board 2 Body'
    ),

     BoardingModel(
      title:'on Board 3 Title',
      image: 'assets/images/onboard_1.jpg',
      body:'on Board 3 Body'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed:
            submit,
              child: Text("Skip".toUpperCase(),)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(

          children: [

            Expanded(

              child: PageView.builder(

                itemBuilder: (BuildContext context, int index)=>buildBoardingItem(boarding[index]),

                itemCount: boarding.length,

                controller: boardController,

                onPageChanged: (int index){

                  if(index == boarding.length -1){

                    setState(() {

                      isLast = true;
                      debugPrint('last');
                    });


                  }else{
                    setState(() {
                      isLast = false;
                      debugPrint('Not last');

                    });

                  }

                },

              ),
            ),

            const SizedBox(height: 30,),
            
            Row(
              children: [

                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 8,
                    expansionFactor: 4,
                    dotWidth: 8,
                    spacing: 5.0,
                  ),

                ),


                const Spacer(),
                
                FloatingActionButton(

                  onPressed: () {

                    if(isLast){

                     submit();

                    }else{
                      boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.ease);

                    }
                    

                  },
                  child: const Icon(Icons.arrow_forward_ios_outlined),
                  
                ),
                
              ]
              
            ),
            
          ],

        ),
      ),


    );


  }

  Widget buildBoardingItem(BoardingModel model )=>Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: [

      Expanded(child: Image(
        image: AssetImage(model.image),
      )),

      const SizedBox(height: 20,),

       Text(model.title,style: const TextStyle(fontSize: 15,),),

      const SizedBox(height: 20,),

       Text(model.body,style: const TextStyle(fontSize: 16),),



    ],

  );

}
