import 'package:homeless/packages.dart';

class TitleView extends StatelessWidget {
  final Widget icon;
  final String titleTxt;
  final String subTxt;
  final AnimationController animationController;
  final Animation animation;
  final String route;

  const TitleView(
      {Key key,
      this.icon,
      this.titleTxt: "",
      this.subTxt: "",
      this.animationController,
      this.route,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation.value), 0.0),
              child: InkWell(
                highlightColor: AppTheme.lightText,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                onTap: () => Navigator.pushNamed(context, this.route),
                child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        icon,
                        SizedBox(width: 10.0),
                        Expanded(
                          child: Text(
                            titleTxt,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: AppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              letterSpacing: 0.5,
                              color: AppTheme.nearlyBlack,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: <Widget>[
                              Text(
                                subTxt,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: AppTheme.fontName,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  letterSpacing: 0.5,
                                  color: AppTheme.nearlyBlack,
                                ),
                              ),
                              SizedBox(
                                height: 38,
                                width: 26,
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppTheme.darkText,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
