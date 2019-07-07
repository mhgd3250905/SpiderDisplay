import 'package:flutter/material.dart';
import 'package:spider_display/Utils/router_anim_utils.dart';

/**
 * 跳转管理
 */
class NavigatorRouterUtils {
  /**
   * 跳转到指定page
   */
  static void pushToPage(BuildContext context, Widget page) {
    Navigator.of(context).push(new PageRouteBuilder(pageBuilder:
        (BuildContext c, Animation<double> animation,
            Animation<double> secondartAnimation) {
      return page;
    }, transitionsBuilder: (BuildContext c, Animation<double> animation,
        Animation<double> secondartAnimation, Widget child) {
      return RouterAnim.createTransition(animation, child);
    }));
  }
}
