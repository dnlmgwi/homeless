import 'package:homeless/packages.dart';
import 'dart:math' as math;

class BottomBarView extends StatefulWidget {
  final Function(int index) changeIndex;
  final Function addClick;
  final List<TabIconData> tabIconsList;

  const BottomBarView(
      {Key key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  double topBarOpacity = 0.0;

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

  AnimationController animationController;

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 100),
    );
    animationController.forward();
    super.initState();
  }

  _alert({context, error}) {
    showDialog(
        context: context, //builds a context of its own
        builder: (BuildContext context) {
          return RichAlertDialog(
            //uses the custom alert dialog imported
            alertTitle: richTitle("Network Error"),
            alertSubtitle: richSubtitle(
                "This feature requires internet access.\n Please turn on mobile data or Wifi"),
            alertType: RichAlertType.ERROR,
            actions: <Widget>[
              RaisedButton(
                child: Text('Try Again'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/dash');
                }, //closes the dialogue
              )
            ],
          );
        });
  }

  String qrCode;

  Future<String> _scan() async {
    //_scan() Receives QR code String and stores value in qrCodeScanRec
    String scanData = await FlutterBarcodeScanner.scanBarcode(
      "#32CD32",
      "Back",
      true,
      ScanMode.QR,
    );
    try {
      setState(() {
        //calling setstate to update UI with the link of the current user
        if (scanData.isNotEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScanScreen(id: scanData),
              ));
        } else {
          _alert(context: this.context);
          this.qrCode = 'No Data';
        }
      });
      // _launchURL(qrCode); // uses barcode parameter once its a valid link.

    } on PlatformException catch (e) {
      //Permission handling is done by the QR Scanner.
      if (e.code == qrCode) {
        setState(() {
          this.qrCode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.qrCode = 'Unknown error: $e');
      }
    } on FormatException {
      setState(() => this.qrCode =
          'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.qrCode = 'Unknown error: $e');
    }

    return scanData;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child) {
            return new Transform(
              transform: new Matrix4.translationValues(0.0, 0.0, 0.0),
              child: new PhysicalShape(
                color: AppTheme.white,
                elevation: 16.0,
                clipper: TabClipper(
                    radius: Tween(begin: 0.0, end: 1.0)
                            .animate(CurvedAnimation(
                                parent: animationController,
                                curve: Curves.fastOutSlowIn))
                            .value *
                        38.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[0],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[0]);
                                    widget.changeIndex(0);
                                  }),
                            ),
                            SizedBox(
                              width: Tween(begin: 0.0, end: 1.0)
                                      .animate(CurvedAnimation(
                                          parent: animationController,
                                          curve: Curves.fastOutSlowIn))
                                      .value *
                                  64.0,
                            ),
                            Expanded(
                              child: TabIcons(
                                  tabIconData: widget.tabIconsList[1],
                                  removeAllSelect: () {
                                    setRemoveAllSelection(
                                        widget.tabIconsList[1]);
                                    widget.changeIndex(1);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 + 62.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 38 * 2.0,
                height: 38 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Curves.fastOutSlowIn)),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyBlack,
                        gradient: LinearGradient(
                            colors: [
                              AppTheme.nearlyBlack,
                              AppTheme.dark_grey,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: AppTheme.nearlyBlack.withOpacity(0.4),
                              offset: Offset(8.0, 8.0),
                              blurRadius: 16.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(0.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            _scan();

//                            Navigator.pushNamed(context, '/scan');
                          },
                          child: Icon(
                            //This is the Icon for a QR Code
                            Icons.center_focus_weak,
                            color: AppTheme.white,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcons extends StatefulWidget {
  final TabIconData tabIconData;
  final Function removeAllSelect;

  const TabIcons({Key key, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData.animationController = new AnimationController(
      vsync: this,
      duration: new Duration(milliseconds: 600),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect();
          widget.tabIconData.animationController.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if (!widget.tabIconData.isSelected) {
              setAnimation();
            }
          },
          child: IgnorePointer(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                new ScaleTransition(
                  alignment: Alignment.center,
                  scale: Tween(begin: 0.9, end: 1.0).animate(CurvedAnimation(
                      parent: widget.tabIconData.animationController,
                      curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn))),
                  child: (widget.tabIconData.isSelected
                      ? widget.tabIconData.iconSelected
                      : widget.tabIconData.icon),
                ),
                Positioned(
                  top: 4,
                  left: 6,
                  right: 0,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: widget.tabIconData.animationController,
                        curve:
                            Interval(0.2, 1.0, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: AppTheme.deactivatedText,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 6,
                  bottom: 8,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: widget.tabIconData.animationController,
                        curve:
                            Interval(0.5, 0.8, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyBlack,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 8,
                  bottom: 0,
                  child: new ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: widget.tabIconData.animationController,
                        curve:
                            Interval(0.5, 0.6, curve: Curves.fastOutSlowIn))),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppTheme.nearlyBlack,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabClipper extends CustomClipper<Path> {
  final double radius;

  TabClipper({this.radius = 38.0});

  @override
  Path getClip(Size size) {
    final path = Path();

    final vertex = radius * 2;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(((size.width / 2) - vertex / 2) - radius + vertex * 0.04,
            0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(
        Rect.fromLTWH(
            (size.width / 2) - vertex / 2, -vertex / 2, vertex, vertex),
        degreeToRadians(160),
        degreeToRadians(-140),
        false);

    path.arcTo(
        Rect.fromLTWH(
            (size.width - ((size.width / 2) - vertex / 2)) - vertex * 0.04,
            0,
            radius,
            radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TabClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    var redian = (math.pi / 180) * degree;
    return redian;
  }
}
