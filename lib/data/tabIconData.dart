import 'package:homeless/packages.dart';

class TabIconData {
  Icon icon;
  Icon iconSelected;
  bool isSelected;
  int index;
  AnimationController animationController;

  TabIconData({
    this.index = 0,
    this.isSelected = false,
    this.animationController,
    this.icon,
    this.iconSelected,
  });

  //Bottom Tab Icons Settings and Menu
  static List<TabIconData> tabIconsList = [
    TabIconData(
      icon: Icon(
        FontAwesomeIcons.stream,
        color: AppTheme.deactivatedText,
        size: 30.0,
      ),
      iconSelected: Icon(
        FontAwesomeIcons.stream,
        color: AppTheme.nearlyBlack,
        size: 37.0,
      ),
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      index: 1,
      isSelected: false,
      animationController: null,
      icon: Icon(
        Icons.settings,
        color: AppTheme.deactivatedText,
        size: 30.0,
      ),
      iconSelected: Icon(
        Icons.settings,
        color: AppTheme.nearlyBlack,
        size: 37.0,
      ),
    ),
  ];
}
