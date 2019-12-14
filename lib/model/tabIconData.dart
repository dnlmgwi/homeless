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

  static List<TabIconData> tabIconsList = [
    TabIconData(
      icon: Icon(
        Icons.dashboard,
        color: AppTheme.deactivatedText,
        size: 23.0,
      ),
      iconSelected: Icon(
        Icons.dashboard,
        color: AppTheme.nearlyBlack,
        size: 30.0,
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
        size: 23.0,
      ),
      iconSelected: Icon(
        Icons.settings,
        color: AppTheme.nearlyBlack,
        size: 30.0,
      ),
    ),
  ];
}
