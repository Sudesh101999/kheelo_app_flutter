import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late VideoPlayerController _videoPlayerController;

  bool mostPopularVisible = false;
  bool playtechLiveVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initVideoPlayer();
  }

  void _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.network(
      'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    )..initialize().then((_) async {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

      setState(() {});
    }).onError((error, stackTrace) {
      print("video init onerror: $error");
    }).catchError((e) {
      print("video init catch error: $e");
    });
    // _videoPlayerController.play();

/*    uint8list = await VideoThumbnail.thumbnailFile(
      video: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.WEBP,
      maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //heder part
            hedder(),

            //main part
            mainPage(),

            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              child: futerWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget hedder() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      color: Color(0xff0b001c),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 3),
            child: Image.asset('assets/logo.gif'),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 60,
              // width: 40,
              child: Column(
                children: [
                  Image.asset(
                    'assets/promotion_icon.png',
                    height: 40,
                    width: 30,
                  ),
                  Text(
                    "Promotions",
                    style: TextStyle(color: Color(0xfff7ad07), fontSize: 12),
                  )
                ],
              ),
            ),
          ),
          Container(
            // height: 50,
              width: 110,
              color: Color(0xfff7ad07),
              child: Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              )),
        ],
      ),
    );
  }

  Widget mainPage() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7271,
      // color: Colors.blue,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //slider container
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
              child: Column(
                children: [
                  CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 32.0,
                            height: 4.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40.0),
                                bottomRight: Radius.circular(40.0),
                                topLeft: Radius.circular(40.0),
                                bottomLeft: Radius.circular(40.0),
                              ),
                              color: _current == entry.key
                                  ? Color(0xfff4ad09)
                                  : Color(0xff707070),
                            ),
                          ));
                    }).toList(),
                  ),
                ],
              ),
            ),

            //language changer container
            Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff9c761d),
                          Color(0xfff5e1b9),
                          Color(0xff9c761d)
                        ])),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff63007c),
                              Color(0xff8400c8),
                              Color(0xff63007c),
                            ])),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "English",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xfff7ad07)),
                          ),
                          Text(
                            "हिन्दी",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xfff7ad07)),
                          ),
                          Text(
                            "తెలుగు",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xfff7ad07)),
                          ),
                          Text(
                            "ಕನ್ನಡ",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xfff7ad07)),
                          ),
                          Text(
                            "मराठी",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xfff7ad07)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),

            SizedBox(
              height: 20,
            ),
            //live withdrawal
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GradientText(
                'LIVE WITHDRAWAL',
                style: const TextStyle(fontSize: 40),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xff9c761d),
                    Color(0xfff5e1b9),
                    Color(0xffffffff),
                  ],
                ),
              ),
            ),
            Container(
              height: 4,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                  bottomLeft: Radius.circular(40.0),
                ),
                color: Color(0xfff4ad09),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Container(
                // height: 220,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xff9c761d),
                          Color(0xfff5e1b9),
                          Color(0xff9c761d)
                        ]),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color(0xff63007c),
                              Color(0xff8400c8),
                              Color(0xff63007c),
                            ]),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        )),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              liveWithdrawalContainer(
                                  "Prarna ₹ 29950", "1 sec ago"),
                              liveWithdrawalContainer(
                                  "Prarna ₹ 29950", "1 sec ago"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              liveWithdrawalContainer(
                                  "Prarna ₹ 29950", "1 sec ago"),
                              liveWithdrawalContainer(
                                  "Prarna ₹ 29950", "1 sec ago"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            //video
            Container(
              height: 250,
              child: _videoPlayerController.value.isInitialized
              // ? Image.file(uint8list!)
                  ? videoPlayerWidget()
                  : Container(),
            ),


            //GAME WIDGET
            mostPopularGameWidget(),

            //playtech live
            playTechLiveWidget(),

            //main futer
            mainFuterWidget(),

          ],
        ),
      ),
    );
  }

  Widget futerWidget() {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xffffd58e),
                      Color(0xffbd963d),
                      Color(0xff8d680a)
                    ])),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    child: Column(
                      children: [
                        Icon(Icons.volume_up_outlined,size: 50,color: Colors.white,),
                        Text("Sport",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Icon(Icons.person_outline,size: 50,color: Colors.white,),
                        Text("Sports",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: (MediaQuery.of(context).size.width * 2) / 3,
            // color: Colors.grey,
            child: ClipPath(
              clipper: TrapezoidClipper(),
              child: Container(
                width: (MediaQuery.of(context).size.width * 2) / 2,
                // height: 100,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/sports-new.png',
                              width: 50,
                              height: 50,
                            ),
                            Text("Sports",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/casino_icon.png',
                              width: 50,
                              height: 50,
                            ),
                            // Icon(Icons.s)
                            Text("Sports",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  Widget mostPopularGameWidget(){
    return Column(
      children: [
        //games
        SizedBox(height: 20,),

        Align(
          alignment: Alignment.topLeft,
          child: Container(
            height: 4,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
                bottomLeft: Radius.circular(40.0),
              ),
              color: Color(0xfff4ad09),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GradientText(
            'GAMES',
            style: const TextStyle(fontSize: 40),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff9c761d),
                Color(0xfff5e1b9),
                Color(0xffffffff),
              ],
            ),
          ),
        ),
        Container(
          height: 4,
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
              bottomLeft: Radius.circular(40.0),
            ),
            color: Color(0xfff4ad09),
          ),
        ),
        SizedBox(
          height: 20,
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                    color: Color(0xfff4ad09),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Most Popular (15)",style: TextStyle(color: Colors.white,fontSize: 22),),
                ),

                const Spacer(),
                InkWell(
                  onTap: (){
                    setState(() {
                      mostPopularVisible = !mostPopularVisible;
                    });
                  },
                  child: Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      color: Color(0xfff4ad09),
                    ),
                    child: Center(
                      child: Text(
                        mostPopularVisible?"Hide":"Show More",
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://cdn.hub88.io/spribe/sbe_aviator.png',
                    "Min. ₹ 10",
                    "Max. ₹ 100k"
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/evo_monopoly_live/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/roy_teen_patti/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/tvb_teen_patti/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),

          ],
        ),

        Visibility(
            visible: mostPopularVisible,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/evo_teen_patti/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/kng_teen_patti/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/ezg_andar_bahar/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/ezg_andar_bahar_lobby/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/jil_andar_bahar/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/kng_andar_bahar/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/tvb_andar_bahar/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/aug_andar_bahar/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/aug_andar_bahar_virtual/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/evo_crazy_time/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/evo_dream_catcher/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget mainFuterWidget(){
    return Column(
      children: [
        SizedBox(height: 40,),
        Divider(
          height: 5,
          color: Color(0xff505050),
        ),
        SizedBox(height: 40,),

        Align(
          alignment: Alignment.center,
          child: Image.asset('assets/logo.gif',height: 90),
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              'India\'s Best Online Casino Slot & Live Games',
              style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '18+ ',
              style: TextStyle(color: Color(0xfff4ad09),fontSize: 14,fontWeight: FontWeight.w400),
            ),
            Text(
              'Be Responsible',
              style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),
            ),
          ],
        ),

        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GENERAL INFO',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'About Us',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Contact Us',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Blog',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Links',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Kheloo Program Affliates',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'FAQs',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Invite Friend',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GAMES',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Invite Friend',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Casino Slot Games',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Casino Table Games',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Casino Bonus & Offers',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Kheloo Privileges',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Tournaments',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Security & Policy',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,color: Colors.white),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Disclaimer',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Cookie Policy',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Disconnection Policy',
                    style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),


        SizedBox(height: 30,),

        //get in tuch

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GradientText(
            'GET IN TOUCH',
            style: const TextStyle(fontSize: 23),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff9c761d),
                Color(0xfff5e1b9),
                Color(0xffffffff),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              InkWell(
                onTap: (){ },
                child: Image.asset('assets/pinterest.png',height: 50,width: 50),
              ),
              InkWell(
                onTap: (){ },
                child: Image.asset('assets/instagram.png',height: 50,width: 50),
              ),
              InkWell(
                onTap: (){ },
                child: Image.asset('assets/twitter.png',height: 50,width: 50),
              ),
              InkWell(
                onTap: (){ },
                child: Image.asset('assets/youtube.png',height: 50,width: 50),
              ),
              InkWell(
                onTap: (){ },
                child: Image.asset('assets/linkedin.png',height: 50,width: 50),
              ),
            ],
          ),
        ),

        SizedBox(height: 20,),
        Container(
          height: 180,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: Colors.grey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 250,
                  color: Color(0xff3a3a3a),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('EXCELLENT SERVICE',style: TextStyle(color: Colors.white,fontSize: 17),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: Color(0xffd46d37),
                              size: 40,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffd46d37),
                              size: 40,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffd46d37),
                              size: 40,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffd46d37),
                              size: 40,
                            ),
                            Icon(
                              Icons.star,
                              color: Color(0xffd46d37),
                              size: 40,
                            ),
                          ],
                        ),
                        Text(
                          '5.0/5.0 - 6834 ratings',
                          style: TextStyle(color: Colors.white,fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Jun. 2020',
                        style: TextStyle(),
                      ),
                      SizedBox(width: 15,),
                      Text(
                        'Verified by LiveChat',
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        //Payment Methods
        paymentMethodWidget(),


      ],
    );
  }

  Widget playTechLiveWidget(){
    return Column(
      children: [
        //games
        SizedBox(height: 20,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 50,
            child: Row(
              children: [
                Container(
                  width: 7,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0),
                    ),
                    color: Color(0xfff4ad09),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Playtech Live (103)",style: TextStyle(color: Colors.white,fontSize: 22),),
                ),

                const Spacer(),
                InkWell(
                  onTap: (){
                    setState(() {
                      playtechLiveVisible = !playtechLiveVisible;
                    });
                  },
                  child: Container(
                    width: 100,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      color: Color(0xfff4ad09),
                    ),
                    child: Center(
                      child: Text(
                        playtechLiveVisible?"Hide":"Show More",
                        style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),),
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                    "Min. ₹ 10",
                    "Max. ₹ 100k"
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: gamesContainer(
                    'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                    "Min. ₹ 100",
                    "Max. ₹ 100k"
                ),
              ),
            ),

          ],
        ),

        Visibility(
            visible: playtechLiveVisible,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: gamesContainer(
                            'https://luckmedia.link/pltl_blackjack_6/thumb.webp',
                            "Min. ₹ 100",
                            "Max. ₹ 100k"
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            )
        ),
      ],
    );
  }

  Widget gamesContainer(imageUrl,minText,maxText){
    return Container(
      // height: 160,
      width: 180,
      constraints: BoxConstraints(
          minHeight: 150
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        color: Color(0xfff4ad09),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            color: Color(0xff370145),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18)
                ),
                child: Image.network(imageUrl),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8,bottom: 8,left: 4,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(minText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
                    SizedBox(width: 4,),
                    Container(
                      width: 2,
                      height: 12,
                      color: Color(0xfff4ad09),
                    ),
                    SizedBox(width: 4,),
                    Text(maxText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget videoPlayerWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          VideoPlayer(_videoPlayerController),
          Positioned(
            height: 240,
            width: (MediaQuery.of(context).size.width * 1.85) / 2,
            child: InkWell(
              onTap: () {
                _videoPlayerController.value.isPlaying
                    ? _videoPlayerController.pause()
                    : _videoPlayerController.play();
                setState(() {});
              },
              child: Icon(
                _videoPlayerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.white,
                size: 80,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget liveWithdrawalContainer(textTitle, textTime) {
    return Container(
      // height: 70,
      width: (MediaQuery.of(context).size.width * 0.82) / 2,
      // color: Colors.cyanAccent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 4,
                  color: Color(0xffd57f23),
                ),
                color: Color(0xffffff)),
            child: Center(
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  textTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 13),
                ),
                Text(
                  textTime,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 11),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget paymentMethodWidget(){
    return Column(
      children: [

        SizedBox(height: 30,),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GradientText(
            'Payment Methods'.toUpperCase(),
            style: const TextStyle(fontSize: 23),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xff9c761d),
                Color(0xfff5e1b9),
                Color(0xffffffff),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network('https://kheloo.com/images/bank.png',height: 50,),
              Image.network('https://kheloo.com/images/paytm.png',height: 40,),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 50,right: 50,top: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network('https://kheloo.com/images/phonepe.png',height: 40,),
              Image.network('https://kheloo.com/images/upi.png',height: 40,),
            ],
          ),
        ),
      ],
    );
  }

}

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
    margin: EdgeInsets.all(5.0),
    child: Container(
      // color: Colors.red,
      child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
    ),
  ),
)
    .toList();

final List<String> imgList = [
  'https://kheloo.com/images/10minwith.png',
  'https://kheloo.com/images/Banner18.jpg',
  'https://kheloo.com/images/Banner11.jpg',
  'https://kheloo.com/images/Dil-se-kheloo_375x250.jpg'
];

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style,
      ),
    );
  }
}

class TrapezoidClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(
        size.width * 0.2, size.height); // Move to the bottom-left corner
    path.lineTo(size.width * 0.001, 0); // Line to the top-left corner
    path.lineTo(size.width * 1, 0); // Line to the top-right corner
    path.lineTo(
        size.width * 0.8, size.height); // Line to the bottom-right corner
    path.close(); // Close the path to form a closed trapezoid shape
    return path;
  }

  @override
  bool shouldReclip(TrapezoidClipper oldClipper) => false;
}
