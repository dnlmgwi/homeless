import 'package:homeless/packages.dart';

class OnBoardingScreen extends StatefulWidget {
//  final SharedPreferences prefs;

//  OnBoardingScreen({this.prefs});

//  static List<OnBoardingModel> pages = [
//    OnBoardingModel(
//      title: 'The Homeless App',
//      body:
//          'Are you a community member who loves helping the community, use the Homeless app and help remove the less in homeless',
//      heroAssetPath: SvgPicture.asset('assets/images/useApp-01.svg'),
//    ),
//    OnBoardingModel(
//      title: 'Need Help?',
//      body:
//          'Have you got a job that may require small effort for youth, or manual labour for our older beneficiaries.',
//      heroAssetPath: SvgPicture.asset('assets/images/work-01.svg'),
//    ),
//    OnBoardingModel(
//      title: 'Security',
//      body:
//          'Verify registered  beneficiaries of the homeless app by scanning the QR Code on their ID Cards, and reward them for helping you',
//      heroAssetPath: SvgPicture.asset('assets/images/Security-01.svg'),
//    ),
//    OnBoardingModel(
//      title: 'Tips & Advice',
//      body:
//          'Our app will give you access to relavent Tips & Advice about the Homeless community in your area',
//      heroAssetPath: SvgPicture.asset('assets/images/advice-01.svg'),
//    ),
//    OnBoardingModel(
//      title: 'Donate',
//      body:
//          'Or if you just want to give, you can use our in app payment option to donate at any time. and we will use the money we raise to change lives.',
//      heroAssetPath: SvgPicture.asset('assets/images/gifts-01.svg'),
//    ),
//  ];

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //Handle all the onBoarding screens.
  List<OnBoardingModel> pages = OnBoardingModel.pages;

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Swiper.children(
        index: 0,
        loop: false,
        pagination: new SwiperPagination(
          margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
          builder: new DotSwiperPaginationBuilder(
              color: AppTheme.grey,
              activeColor: AppTheme.dark_grey,
              size: 7.0,
              activeSize: 16.0),
        ),
        control: SwiperControl(
          iconPrevious: null,
          iconNext: null,
        ),
        children: _getPages(context),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < pages.length; i++) {
      OnBoardingModel page = pages[i];
      widgets.add(
        new Container(
          color: AppTheme.chipBackground,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: SizedBox(
                  child: page.heroAssetPath,
                  width: 250.0,
                  height: 250.0,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text(page.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTheme.title),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  page.body,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: AppTheme.body1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: page.widget,
              ),
            ],
          ),
        ),
      );
    }
    widgets.add(
      new Container(
        color: AppTheme.chipBackground,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              Icon(
//                FontAwesomeIcons.qrcode,
//                size: 125.0,
//                color: AppTheme.nearlyBlack,
//              ),
              SvgPicture.asset(
                'assets/images/HelpingPerson-01.svg',
                width: 300,
                height: 300,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 50.0, right: 15.0, left: 15.0),
                child: Text("Do Your Part, using the homeless app",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTheme.body2),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, right: 15.0, left: 15.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(50.0),
                  ),
                  child: Text(
                    "Start",
                  ),
                  textColor: AppTheme.white,
                  onPressed: () {
//                    widget.prefs.setBool('seen', true);
                    Navigator.pushNamed(context, '/dash');
                  },
                  splashColor: AppTheme.nearlyWhite,
                  color: AppTheme.nearlyBlack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return widgets;
  }
}
