import 'package:homeless/packages.dart';

class LogoutView extends StatelessWidget {
  final Widget icon;
  final String titleTxt;
  final AnimationController animationController;
  final Animation animation;
  final Function function;

  const LogoutView(
      {Key key,
      this.icon,
      this.titleTxt: "",
      this.animationController,
      this.function,
      this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: AppTheme.grey.withOpacity(0.2),
//                                         offset: Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - animation.value), 0.0),
                child: InkWell(
                  highlightColor: AppTheme.lightText,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  onTap: () => function,
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
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
