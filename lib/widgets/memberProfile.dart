import 'package:homeless/packages.dart';

class MemberProfile extends StatelessWidget {
  final Widget name;
  final AnimationController animationController;
  final Animation animation;

  const MemberProfile(
      {Key key, this.name, this.animationController, this.animation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - animation.value), 0.0),
              child: InkWell(
                highlightColor: AppTheme.lightText,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Container(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 8, bottom: 8),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 10.0),
                        Expanded(
                          child: name,
                        ),
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
