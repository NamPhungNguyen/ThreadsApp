class AppBasePath {
  static String icon(String folder, String file) =>
      'assets/icons/$folder/$file';
  static String iconRoot(String file) => 'assets/icons/$file';
  static String image(String folder, String file) =>
      'assets/images/$folder/$file';
}

class AppIcons {
  static const String _bottomBar = 'iconBottomBar';
  static String get home => AppBasePath.icon(_bottomBar, 'feed.svg');
  static String get homeFilled =>
      AppBasePath.icon(_bottomBar, 'feed_filled.svg');

  static String get explore => AppBasePath.icon(_bottomBar, 'explore.svg');
  static String get exploreFilled =>
      AppBasePath.icon(_bottomBar, 'explore_filled.svg');

  static String get write => AppBasePath.icon(_bottomBar, 'write.svg');
  static String get writeFilled =>
      AppBasePath.icon(_bottomBar, 'write_filled.svg');

  static String get heart => AppBasePath.icon(_bottomBar, 'heart.svg');
  static String get heartFilled =>
      AppBasePath.icon(_bottomBar, 'heart_filled.svg');

  static String get user => AppBasePath.icon(_bottomBar, 'user.svg');
  static String get userFilled =>
      AppBasePath.icon(_bottomBar, 'user_filled.svg');
  static String get threads => AppBasePath.iconRoot('threads.svg');
  static String get cross => AppBasePath.iconRoot('cross.svg');
  static String get dots => AppBasePath.iconRoot('3dots.svg');
  static String get verified => AppBasePath.iconRoot('verified.svg');
  static String get repost => AppBasePath.iconRoot('repost.svg');
  static String get send => AppBasePath.iconRoot('send.svg');
  static String get message => AppBasePath.iconRoot('message.svg');
  static String get heartPost => AppBasePath.iconRoot('heart_post.svg');
}

class AppImages {
  // example
  static const String onboarding1 = 'onboarding1.png';
  static const String onboarding2 = 'onboarding2.png';
}
