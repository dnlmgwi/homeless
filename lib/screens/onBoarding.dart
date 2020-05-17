import 'package:homeless/packages.dart';
import 'package:homeless/services/sharePreferenceService.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen();

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  //Handle all the onBoarding screens.
  List<OnBoardingModel> pages = OnBoardingModel.pages;

  List<Widget> widgets = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Swiper.children(
          index: 0,
          loop: false,
          pagination: SwiperPagination(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 40.0),
            builder: DotSwiperPaginationBuilder(
                color: AppTheme.grey,
                activeColor: AppTheme.dark_grey,
                space: 10,
                size: 7.0,
                activeSize: 16.0),
          ),
          control: SwiperControl(
            iconPrevious: null,
            iconNext: null,
          ),
          children: _getPages(context),
        ),
      ),
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < pages.length; i++) {
      OnBoardingModel page = pages[i];
      widgets.add(
        Container(
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, right: 15.0, left: 15.0, bottom: 50.0),
                child: Text("Made possible by",
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: AppTheme.headline),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/Liberty3.png',
                    width: 300,
                    height: 200,
                  ),
                  Image.asset(
                    'assets/images/UNDPLogo2020.jpg',
                    width: 300,
                    height: 200,
                  ),
                ],
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
                    Navigator.pushReplacementNamed(context, '/login');
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
