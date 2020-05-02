import 'package:homeless/packages.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final summary =
      'Our Mobile App is still under development and we have come a long way, but the future looks bright...';

  String feedback = '';

  @override
  void initState() {
    super.initState();
  }

//Opens whatapp to share feedback message.
  _launchMail() async {
    FlutterOpenWhatsapp.sendSingleMessage(
        "+27722326766", "Homeless App Feedback: $feedback");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.chipBackground,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          titleSpacing: 1.2,
          centerTitle: false,
          backgroundColor: AppTheme.chipBackground,
          title: Text("Feedback",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: AppTheme.fontName,
                fontWeight: FontWeight.w700,
                fontSize: 22,
                letterSpacing: 1.2,
                color: AppTheme.dark_grey,
              ))),
      body: KeyboardAvoider(
        autoScroll: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 500,
              height: 155,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top, left: 16, right: 16),
              child: SvgPicture.asset('assets/images/feedbackImage-01.svg'),
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
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'This feature uses whatsapp',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Text(
                "$summary",
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
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
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
                        FocusScope.of(context).requestFocus(FocusNode());
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
