import 'package:homeless/packages.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final summary = [
    'Our Mobile App is still under production and we have come a long way, currently it is only available on Android but the future looks bright...'
  ];

  String feedback = '';

  @override
  void initState() {
    super.initState();
  }

  _launchMail() async {
    String url =
        'mailto:<info@homeless.com>?subject=Homeless App Info&body=$feedback';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: AppTheme.chipBackground,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
              titleSpacing: 1.2,
              centerTitle: false,
              backgroundColor: AppTheme.dark_grey,
              title: Text("Feedback",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: AppTheme.fontName,
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    letterSpacing: 1.2,
                    color: AppTheme.nearlyWhite,
                  ))),
          body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 500,
                        height: 155,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            left: 16,
                            right: 16),
                        child: Image.asset("assets/images/feedbackImage.png"),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          'We Value Your FeedBack',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "${summary[0]}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: AppTheme.fontName,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            letterSpacing: 0.5,
                            color: AppTheme.nearlyBlack,
                          ),
                        ),
                      ),
                      _buildComposer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: Container(
                            width: 120,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppTheme.nearlyBlack,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: Offset(4, 4),
                                    blurRadius: 8.0),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _launchMail();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Send',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.notWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: new BoxDecoration(
          color: AppTheme.white,
          borderRadius: new BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(25),
          child: Container(
            padding: EdgeInsets.all(4.0),
            constraints: BoxConstraints(minHeight: 80, maxHeight: 160),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: TextField(
                maxLines: null,
                onChanged: (String txt) {
                  setState(() {
                    feedback = txt;
                  });
                },
                style: TextStyle(
                  fontFamily: AppTheme.fontName,
                  fontSize: 16,
                  color: AppTheme.dark_grey,
                ),
                cursorColor: AppTheme.nearlyBlack,
                decoration: new InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter your feedback..."),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
