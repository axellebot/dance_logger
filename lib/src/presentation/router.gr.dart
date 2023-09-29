// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ArtistCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ArtistCreatePage()),
      );
    },
    ArtistDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ArtistDetailsRouteArgs>(
          orElse: () => ArtistDetailsRouteArgs(ofArtistId: pathParams.optString('ofArtistId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistDetailsPage(
          key: args.key,
          artistDetailBloc: args.artistDetailBloc,
          ofArtist: args.ofArtist,
          ofArtistId: args.ofArtistId,
        )),
      );
    },
    ArtistEditRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistEditRouteArgs>(orElse: () => const ArtistEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistEditPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    ArtistListRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistListRouteArgs>(
          orElse: () => const ArtistListRouteArgs());
      return AutoRoutePage<List<ArtistViewModel>>(
        routeData: routeData,
        child: ArtistListPage(
          key: args.key,
          showAppBar: args.showAppBar,
          titleText: args.titleText,
          shouldSelectOne: args.shouldSelectOne,
          shouldSelectMultiple: args.shouldSelectMultiple,
          preselectedItems: args.preselectedItems,
          artistListBloc: args.artistListBloc,
          ofSearch: args.ofSearch,
          ofDanceId: args.ofDanceId,
          ofFigureId: args.ofFigureId,
          ofVideoId: args.ofVideoId,
        ),
      );
    },
    DanceCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DanceCreatePage()),
      );
    },
    DanceDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DanceDetailsRouteArgs>(
          orElse: () => DanceDetailsRouteArgs(ofDanceId: pathParams.optString('ofDanceId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceDetailsPage(
          key: args.key,
          danceDetailBloc: args.danceDetailBloc,
          ofDance: args.ofDance,
          ofDanceId: args.ofDanceId,
        )),
      );
    },
    DanceEditRoute.name: (routeData) {
      final args = routeData.argsAs<DanceEditRouteArgs>(orElse: () => const DanceEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceEditPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(orElse: () => const DanceListRouteArgs());
      return AutoRoutePage<List<DanceViewModel>>(
        routeData: routeData,
        child: DanceListPage(
          key: args.key,
          showAppBar: args.showAppBar,
          titleText: args.titleText,
          shouldSelectOne: args.shouldSelectOne,
          shouldSelectMultiple: args.shouldSelectMultiple,
          preselectedItems: args.preselectedItems,
          danceListBloc: args.danceListBloc,
          ofSearch: args.ofSearch,
          ofArtistId: args.ofArtistId,
          ofVideoId: args.ofVideoId,
        ),
      );
    },
    FigureCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const FigureCreatePage()),
      );
    },
    FigureDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<FigureDetailsRouteArgs>(
          orElse: () => FigureDetailsRouteArgs(ofFigureId: pathParams.optString('ofFigureId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: FigureDetailsPage(
          key: args.key,
          figureDetailBloc: args.figureDetailBloc,
          ofFigure: args.ofFigure,
          ofFigureId: args.ofFigureId,
        )),
      );
    },
    FigureEditRoute.name: (routeData) {
      final args = routeData.argsAs<FigureEditRouteArgs>(orElse: () => const FigureEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: FigureEditPage(
          key: args.key,
          figureId: args.figureId,
        )),
      );
    },
    FigureListRoute.name: (routeData) {
      final args = routeData.argsAs<FigureListRouteArgs>(orElse: () => const FigureListRouteArgs());
      return AutoRoutePage<List<FigureViewModel>>(
        routeData: routeData,
        child: FigureListPage(
          key: args.key,
          showAppBar: args.showAppBar,
          titleText: args.titleText,
          shouldSelectOne: args.shouldSelectOne,
          shouldSelectMultiple: args.shouldSelectMultiple,
          preselectedItems: args.preselectedItems,
          figureListBloc: args.figureListBloc,
          ofArtistId: args.ofArtistId,
          ofDanceId: args.ofDanceId,
          ofVideoId: args.ofVideoId,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    MomentCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const MomentCreatePage()),
      );
    },
    MomentEditRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<MomentEditRouteArgs>(
          orElse: () => MomentEditRouteArgs(momentId: pathParams.optString('momentId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: MomentEditPage(
          key: args.key,
          momentId: args.momentId,
        )),
      );
    },
    PracticeCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const PracticeCreatePage()),
      );
    },
    PracticeDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PracticeDetailsRouteArgs>(
          orElse: () => PracticeDetailsRouteArgs(ofPracticeId: pathParams.optString('ofPracticeId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: PracticeDetailsPage(
          key: args.key,
          practiceDetailBloc: args.practiceDetailBloc,
          ofPractice: args.ofPractice,
          ofPracticeId: args.ofPracticeId,
        )),
      );
    },
    PracticeEditRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeEditRouteArgs>(orElse: () => const PracticeEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: PracticeEditPage(
          key: args.key,
          practiceId: args.practiceId,
        )),
      );
    },
    PracticeListRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeListRouteArgs>(
          orElse: () => const PracticeListRouteArgs());
      return AutoRoutePage<List<PracticeViewModel>>(
        routeData: routeData,
        child: PracticeListPage(
          key: args.key,
          showAppBar: args.showAppBar,
          titleText: args.titleText,
          shouldSelectOne: args.shouldSelectOne,
          shouldSelectMultiple: args.shouldSelectMultiple,
          preselectedItems: args.preselectedItems,
          practiceListBloc: args.practiceListBloc,
          ofArtistId: args.ofArtistId,
          ofDanceId: args.ofDanceId,
          ofFigureId: args.ofFigureId,
          ofVideoId: args.ofVideoId,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
    VideoCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const VideoCreatePage()),
      );
    },
    VideoDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VideoDetailsRouteArgs>(
          orElse: () => VideoDetailsRouteArgs(
              ofVideoId: pathParams.optString('ofVideoId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: VideoDetailsPage(
          key: args.key,
          videoDetailBloc: args.videoDetailBloc,
          ofVideo: args.ofVideo,
          ofVideoId: args.ofVideoId,
        )),
      );
    },
    VideoEditRoute.name: (routeData) {
      final args = routeData.argsAs<VideoEditRouteArgs>(
          orElse: () => const VideoEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: VideoEditPage(
          key: args.key,
          videoId: args.videoId,
        )),
      );
    },
    VideoListRoute.name: (routeData) {
      final args = routeData.argsAs<VideoListRouteArgs>(
          orElse: () => const VideoListRouteArgs());
      return AutoRoutePage<List<VideoViewModel>>(
        routeData: routeData,
        child: VideoListPage(
          key: args.key,
          showAppBar: args.showAppBar,
          titleText: args.titleText,
          shouldSelectOne: args.shouldSelectOne,
          shouldSelectMultiple: args.shouldSelectMultiple,
          preselectedItems: args.preselectedItems,
          videoListBloc: args.videoListBloc,
          ofSearch: args.ofSearch,
          ofArtistId: args.ofArtistId,
          ofDanceId: args.ofDanceId,
          ofFigureId: args.ofFigureId,
        ),
      );
    },
  };
}

/// generated route for
/// [ArtistCreatePage]
class ArtistCreateRoute extends PageRouteInfo<void> {
  const ArtistCreateRoute({List<PageRouteInfo>? children})
      : super(
          ArtistCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'ArtistCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ArtistDetailsPage]
class ArtistDetailsRoute extends PageRouteInfo<ArtistDetailsRouteArgs> {
  ArtistDetailsRoute({
    Key? key,
    ArtistDetailBloc? artistDetailBloc,
    ArtistViewModel? ofArtist,
    String? ofArtistId,
    List<PageRouteInfo>? children,
  }) : super(
          ArtistDetailsRoute.name,
          args: ArtistDetailsRouteArgs(
            key: key,
            artistDetailBloc: artistDetailBloc,
            ofArtist: ofArtist,
            ofArtistId: ofArtistId,
          ),
          rawPathParams: {'ofArtistId': ofArtistId},
          initialChildren: children,
        );

  static const String name = 'ArtistDetailsRoute';

  static const PageInfo<ArtistDetailsRouteArgs> page = PageInfo<ArtistDetailsRouteArgs>(name);
}

class ArtistDetailsRouteArgs {
  const ArtistDetailsRouteArgs({
    this.key,
    this.artistDetailBloc,
    this.ofArtist,
    this.ofArtistId,
  });

  final Key? key;

  final ArtistDetailBloc? artistDetailBloc;

  final ArtistViewModel? ofArtist;

  final String? ofArtistId;

  @override
  String toString() {
    return 'ArtistDetailsRouteArgs{key: $key, artistDetailBloc: $artistDetailBloc, ofArtist: $ofArtist, ofArtistId: $ofArtistId}';
  }
}

/// generated route for
/// [ArtistEditPage]
class ArtistEditRoute extends PageRouteInfo<ArtistEditRouteArgs> {
  ArtistEditRoute({
    Key? key,
    String? artistId,
    List<PageRouteInfo>? children,
  }) : super(
          ArtistEditRoute.name,
          args: ArtistEditRouteArgs(
            key: key,
            artistId: artistId,
          ),
          initialChildren: children,
        );

  static const String name = 'ArtistEditRoute';

  static const PageInfo<ArtistEditRouteArgs> page = PageInfo<ArtistEditRouteArgs>(name);
}

class ArtistEditRouteArgs {
  const ArtistEditRouteArgs({
    this.key,
    this.artistId,
  });

  final Key? key;

  final String? artistId;

  @override
  String toString() {
    return 'ArtistEditRouteArgs{key: $key, artistId: $artistId}';
  }
}

/// generated route for
/// [ArtistListPage]
class ArtistListRoute extends PageRouteInfo<ArtistListRouteArgs> {
  ArtistListRoute({
    Key? key,
    bool showAppBar = true,
    String? titleText,
    bool shouldSelectOne = false,
    bool shouldSelectMultiple = false,
    List<ArtistViewModel>? preselectedItems,
    ArtistListBloc? artistListBloc,
    String? ofSearch,
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
    List<PageRouteInfo>? children,
  }) : super(
          ArtistListRoute.name,
          args: ArtistListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            artistListBloc: artistListBloc,
            ofSearch: ofSearch,
            ofDanceId: ofDanceId,
            ofFigureId: ofFigureId,
            ofVideoId: ofVideoId,
          ),
          initialChildren: children,
        );

  static const String name = 'ArtistListRoute';

  static const PageInfo<ArtistListRouteArgs> page =
      PageInfo<ArtistListRouteArgs>(name);
}

class ArtistListRouteArgs {
  const ArtistListRouteArgs({
    this.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,
    this.artistListBloc,
    this.ofSearch,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<ArtistViewModel>? preselectedItems;

  final ArtistListBloc? artistListBloc;

  final String? ofSearch;

  final String? ofDanceId;

  final String? ofFigureId;

  final String? ofVideoId;

  @override
  String toString() {
    return 'ArtistListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, artistListBloc: $artistListBloc, ofSearch: $ofSearch, ofDanceId: $ofDanceId, ofFigureId: $ofFigureId, ofVideoId: $ofVideoId}';
  }
}

/// generated route for
/// [DanceCreatePage]
class DanceCreateRoute extends PageRouteInfo<void> {
  const DanceCreateRoute({List<PageRouteInfo>? children})
      : super(
          DanceCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'DanceCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DanceDetailsPage]
class DanceDetailsRoute extends PageRouteInfo<DanceDetailsRouteArgs> {
  DanceDetailsRoute({
    Key? key,
    DanceDetailBloc? danceDetailBloc,
    DanceViewModel? ofDance,
    String? ofDanceId,
    List<PageRouteInfo>? children,
  }) : super(
          DanceDetailsRoute.name,
          args: DanceDetailsRouteArgs(
            key: key,
            danceDetailBloc: danceDetailBloc,
            ofDance: ofDance,
            ofDanceId: ofDanceId,
          ),
          rawPathParams: {'ofDanceId': ofDanceId},
          initialChildren: children,
        );

  static const String name = 'DanceDetailsRoute';

  static const PageInfo<DanceDetailsRouteArgs> page = PageInfo<DanceDetailsRouteArgs>(name);
}

class DanceDetailsRouteArgs {
  const DanceDetailsRouteArgs({
    this.key,
    this.danceDetailBloc,
    this.ofDance,
    this.ofDanceId,
  });

  final Key? key;

  final DanceDetailBloc? danceDetailBloc;

  final DanceViewModel? ofDance;

  final String? ofDanceId;

  @override
  String toString() {
    return 'DanceDetailsRouteArgs{key: $key, danceDetailBloc: $danceDetailBloc, ofDance: $ofDance, ofDanceId: $ofDanceId}';
  }
}

/// generated route for
/// [DanceEditPage]
class DanceEditRoute extends PageRouteInfo<DanceEditRouteArgs> {
  DanceEditRoute({
    Key? key,
    String? danceId,
    List<PageRouteInfo>? children,
  }) : super(
          DanceEditRoute.name,
          args: DanceEditRouteArgs(
            key: key,
            danceId: danceId,
          ),
          initialChildren: children,
        );

  static const String name = 'DanceEditRoute';

  static const PageInfo<DanceEditRouteArgs> page = PageInfo<DanceEditRouteArgs>(name);
}

class DanceEditRouteArgs {
  const DanceEditRouteArgs({
    this.key,
    this.danceId,
  });

  final Key? key;

  final String? danceId;

  @override
  String toString() {
    return 'DanceEditRouteArgs{key: $key, danceId: $danceId}';
  }
}

/// generated route for
/// [DanceListPage]
class DanceListRoute extends PageRouteInfo<DanceListRouteArgs> {
  DanceListRoute({
    Key? key,
    bool showAppBar = true,
    String? titleText,
    bool shouldSelectOne = false,
    bool shouldSelectMultiple = false,
    List<DanceViewModel>? preselectedItems,
    DanceListBloc? danceListBloc,
    String? ofSearch,
    String? ofArtistId,
    String? ofVideoId,
    List<PageRouteInfo>? children,
  }) : super(
          DanceListRoute.name,
          args: DanceListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            danceListBloc: danceListBloc,
            ofSearch: ofSearch,
            ofArtistId: ofArtistId,
            ofVideoId: ofVideoId,
          ),
          initialChildren: children,
        );

  static const String name = 'DanceListRoute';

  static const PageInfo<DanceListRouteArgs> page =
      PageInfo<DanceListRouteArgs>(name);
}

class DanceListRouteArgs {
  const DanceListRouteArgs({
    this.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,
    this.danceListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<DanceViewModel>? preselectedItems;

  final DanceListBloc? danceListBloc;

  final String? ofSearch;

  final String? ofArtistId;

  final String? ofVideoId;

  @override
  String toString() {
    return 'DanceListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, danceListBloc: $danceListBloc, ofSearch: $ofSearch, ofArtistId: $ofArtistId, ofVideoId: $ofVideoId}';
  }
}

/// generated route for
/// [FigureCreatePage]
class FigureCreateRoute extends PageRouteInfo<void> {
  const FigureCreateRoute({List<PageRouteInfo>? children})
      : super(
          FigureCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'FigureCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FigureDetailsPage]
class FigureDetailsRoute extends PageRouteInfo<FigureDetailsRouteArgs> {
  FigureDetailsRoute({
    Key? key,
    FigureDetailBloc? figureDetailBloc,
    FigureViewModel? ofFigure,
    String? ofFigureId,
    List<PageRouteInfo>? children,
  }) : super(
          FigureDetailsRoute.name,
          args: FigureDetailsRouteArgs(
            key: key,
            figureDetailBloc: figureDetailBloc,
            ofFigure: ofFigure,
            ofFigureId: ofFigureId,
          ),
          rawPathParams: {'ofFigureId': ofFigureId},
          initialChildren: children,
        );

  static const String name = 'FigureDetailsRoute';

  static const PageInfo<FigureDetailsRouteArgs> page = PageInfo<FigureDetailsRouteArgs>(name);
}

class FigureDetailsRouteArgs {
  const FigureDetailsRouteArgs({
    this.key,
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,
  });

  final Key? key;

  final FigureDetailBloc? figureDetailBloc;

  final FigureViewModel? ofFigure;

  final String? ofFigureId;

  @override
  String toString() {
    return 'FigureDetailsRouteArgs{key: $key, figureDetailBloc: $figureDetailBloc, ofFigure: $ofFigure, ofFigureId: $ofFigureId}';
  }
}

/// generated route for
/// [FigureEditPage]
class FigureEditRoute extends PageRouteInfo<FigureEditRouteArgs> {
  FigureEditRoute({
    Key? key,
    String? figureId,
    List<PageRouteInfo>? children,
  }) : super(
          FigureEditRoute.name,
          args: FigureEditRouteArgs(
            key: key,
            figureId: figureId,
          ),
          initialChildren: children,
        );

  static const String name = 'FigureEditRoute';

  static const PageInfo<FigureEditRouteArgs> page = PageInfo<FigureEditRouteArgs>(name);
}

class FigureEditRouteArgs {
  const FigureEditRouteArgs({
    this.key,
    this.figureId,
  });

  final Key? key;

  final String? figureId;

  @override
  String toString() {
    return 'FigureEditRouteArgs{key: $key, figureId: $figureId}';
  }
}

/// generated route for
/// [FigureListPage]
class FigureListRoute extends PageRouteInfo<FigureListRouteArgs> {
  FigureListRoute({
    Key? key,
    bool showAppBar = true,
    String? titleText,
    bool shouldSelectOne = false,
    bool shouldSelectMultiple = false,
    List<FigureViewModel>? preselectedItems,
    FigureListBloc? figureListBloc,
    String? ofArtistId,
    String? ofDanceId,
    String? ofVideoId,
    List<PageRouteInfo>? children,
  }) : super(
          FigureListRoute.name,
          args: FigureListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            figureListBloc: figureListBloc,
            ofArtistId: ofArtistId,
            ofDanceId: ofDanceId,
            ofVideoId: ofVideoId,
          ),
          initialChildren: children,
        );

  static const String name = 'FigureListRoute';

  static const PageInfo<FigureListRouteArgs> page = PageInfo<FigureListRouteArgs>(name);
}

class FigureListRouteArgs {
  const FigureListRouteArgs({
    this.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,
    this.figureListBloc,
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<FigureViewModel>? preselectedItems;

  final FigureListBloc? figureListBloc;

  final String? ofArtistId;

  final String? ofDanceId;

  final String? ofVideoId;

  @override
  String toString() {
    return 'FigureListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, figureListBloc: $figureListBloc, ofArtistId: $ofArtistId, ofDanceId: $ofDanceId, ofVideoId: $ofVideoId}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MomentCreatePage]
class MomentCreateRoute extends PageRouteInfo<void> {
  const MomentCreateRoute({List<PageRouteInfo>? children})
      : super(
          MomentCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'MomentCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MomentEditPage]
class MomentEditRoute extends PageRouteInfo<MomentEditRouteArgs> {
  MomentEditRoute({
    Key? key,
    String? momentId,
    List<PageRouteInfo>? children,
  }) : super(
          MomentEditRoute.name,
          args: MomentEditRouteArgs(
            key: key,
            momentId: momentId,
          ),
          rawPathParams: {'momentId': momentId},
          initialChildren: children,
        );

  static const String name = 'MomentEditRoute';

  static const PageInfo<MomentEditRouteArgs> page =
      PageInfo<MomentEditRouteArgs>(name);
}

class MomentEditRouteArgs {
  const MomentEditRouteArgs({
    this.key,
    this.momentId,
  });

  final Key? key;

  final String? momentId;

  @override
  String toString() {
    return 'MomentEditRouteArgs{key: $key, momentId: $momentId}';
  }
}

/// generated route for
/// [PracticeCreatePage]
class PracticeCreateRoute extends PageRouteInfo<void> {
  const PracticeCreateRoute({List<PageRouteInfo>? children})
      : super(
          PracticeCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'PracticeCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PracticeDetailsPage]
class PracticeDetailsRoute extends PageRouteInfo<PracticeDetailsRouteArgs> {
  PracticeDetailsRoute({
    Key? key,
    PracticeDetailBloc? practiceDetailBloc,
    PracticeViewModel? ofPractice,
    String? ofPracticeId,
    List<PageRouteInfo>? children,
  }) : super(
          PracticeDetailsRoute.name,
          args: PracticeDetailsRouteArgs(
            key: key,
            practiceDetailBloc: practiceDetailBloc,
            ofPractice: ofPractice,
            ofPracticeId: ofPracticeId,
          ),
          rawPathParams: {'ofPracticeId': ofPracticeId},
          initialChildren: children,
        );

  static const String name = 'PracticeDetailsRoute';

  static const PageInfo<PracticeDetailsRouteArgs> page = PageInfo<PracticeDetailsRouteArgs>(name);
}

class PracticeDetailsRouteArgs {
  const PracticeDetailsRouteArgs({
    this.key,
    this.practiceDetailBloc,
    this.ofPractice,
    this.ofPracticeId,
  });

  final Key? key;

  final PracticeDetailBloc? practiceDetailBloc;

  final PracticeViewModel? ofPractice;

  final String? ofPracticeId;

  @override
  String toString() {
    return 'PracticeDetailsRouteArgs{key: $key, practiceDetailBloc: $practiceDetailBloc, ofPractice: $ofPractice, ofPracticeId: $ofPracticeId}';
  }
}

/// generated route for
/// [PracticeEditPage]
class PracticeEditRoute extends PageRouteInfo<PracticeEditRouteArgs> {
  PracticeEditRoute({
    Key? key,
    String? practiceId,
    List<PageRouteInfo>? children,
  }) : super(
          PracticeEditRoute.name,
          args: PracticeEditRouteArgs(
            key: key,
            practiceId: practiceId,
          ),
          initialChildren: children,
        );

  static const String name = 'PracticeEditRoute';

  static const PageInfo<PracticeEditRouteArgs> page = PageInfo<PracticeEditRouteArgs>(name);
}

class PracticeEditRouteArgs {
  const PracticeEditRouteArgs({
    this.key,
    this.practiceId,
  });

  final Key? key;

  final String? practiceId;

  @override
  String toString() {
    return 'PracticeEditRouteArgs{key: $key, practiceId: $practiceId}';
  }
}

/// generated route for
/// [PracticeListPage]
class PracticeListRoute extends PageRouteInfo<PracticeListRouteArgs> {
  PracticeListRoute({
    Key? key,
    bool showAppBar = true,
    String? titleText,
    bool shouldSelectOne = false,
    bool shouldSelectMultiple = false,
    List<PracticeViewModel>? preselectedItems,
    PracticeListBloc? practiceListBloc,
    String? ofArtistId,
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
    List<PageRouteInfo>? children,
  }) : super(
          PracticeListRoute.name,
          args: PracticeListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            practiceListBloc: practiceListBloc,
            ofArtistId: ofArtistId,
            ofDanceId: ofDanceId,
            ofFigureId: ofFigureId,
            ofVideoId: ofVideoId,
          ),
          initialChildren: children,
        );

  static const String name = 'PracticeListRoute';

  static const PageInfo<PracticeListRouteArgs> page =
      PageInfo<PracticeListRouteArgs>(name);
}

class PracticeListRouteArgs {
  const PracticeListRouteArgs({
    this.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,
    this.practiceListBloc,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<PracticeViewModel>? preselectedItems;

  final PracticeListBloc? practiceListBloc;

  final String? ofArtistId;

  final String? ofDanceId;

  final String? ofFigureId;

  final String? ofVideoId;

  @override
  String toString() {
    return 'PracticeListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, practiceListBloc: $practiceListBloc, ofArtistId: $ofArtistId, ofDanceId: $ofDanceId, ofFigureId: $ofFigureId, ofVideoId: $ofVideoId}';
  }
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VideoCreatePage]
class VideoCreateRoute extends PageRouteInfo<void> {
  const VideoCreateRoute({List<PageRouteInfo>? children})
      : super(
          VideoCreateRoute.name,
          initialChildren: children,
        );

  static const String name = 'VideoCreateRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VideoDetailsPage]
class VideoDetailsRoute extends PageRouteInfo<VideoDetailsRouteArgs> {
  VideoDetailsRoute({
    Key? key,
    VideoDetailBloc? videoDetailBloc,
    VideoViewModel? ofVideo,
    String? ofVideoId,
    List<PageRouteInfo>? children,
  }) : super(
          VideoDetailsRoute.name,
          args: VideoDetailsRouteArgs(
            key: key,
            videoDetailBloc: videoDetailBloc,
            ofVideo: ofVideo,
            ofVideoId: ofVideoId,
          ),
          rawPathParams: {'ofVideoId': ofVideoId},
          initialChildren: children,
        );

  static const String name = 'VideoDetailsRoute';

  static const PageInfo<VideoDetailsRouteArgs> page =
      PageInfo<VideoDetailsRouteArgs>(name);
}

class VideoDetailsRouteArgs {
  const VideoDetailsRouteArgs({
    this.key,
    this.videoDetailBloc,
    this.ofVideo,
    this.ofVideoId,
  });

  final Key? key;

  final VideoDetailBloc? videoDetailBloc;

  final VideoViewModel? ofVideo;

  final String? ofVideoId;

  @override
  String toString() {
    return 'VideoDetailsRouteArgs{key: $key, videoDetailBloc: $videoDetailBloc, ofVideo: $ofVideo, ofVideoId: $ofVideoId}';
  }
}

/// generated route for
/// [VideoEditPage]
class VideoEditRoute extends PageRouteInfo<VideoEditRouteArgs> {
  VideoEditRoute({
    Key? key,
    String? videoId,
    List<PageRouteInfo>? children,
  }) : super(
          VideoEditRoute.name,
          args: VideoEditRouteArgs(
            key: key,
            videoId: videoId,
          ),
          initialChildren: children,
        );

  static const String name = 'VideoEditRoute';

  static const PageInfo<VideoEditRouteArgs> page =
      PageInfo<VideoEditRouteArgs>(name);
}

class VideoEditRouteArgs {
  const VideoEditRouteArgs({
    this.key,
    this.videoId,
  });

  final Key? key;

  final String? videoId;

  @override
  String toString() {
    return 'VideoEditRouteArgs{key: $key, videoId: $videoId}';
  }
}

/// generated route for
/// [VideoListPage]
class VideoListRoute extends PageRouteInfo<VideoListRouteArgs> {
  VideoListRoute({
    Key? key,
    bool showAppBar = true,
    String? titleText,
    bool shouldSelectOne = false,
    bool shouldSelectMultiple = false,
    List<VideoViewModel>? preselectedItems,
    VideoListBloc? videoListBloc,
    String? ofSearch,
    String? ofArtistId,
    String? ofDanceId,
    String? ofFigureId,
    List<PageRouteInfo>? children,
  }) : super(
          VideoListRoute.name,
          args: VideoListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            videoListBloc: videoListBloc,
            ofSearch: ofSearch,
            ofArtistId: ofArtistId,
            ofDanceId: ofDanceId,
            ofFigureId: ofFigureId,
          ),
          initialChildren: children,
        );

  static const String name = 'VideoListRoute';

  static const PageInfo<VideoListRouteArgs> page =
      PageInfo<VideoListRouteArgs>(name);
}

class VideoListRouteArgs {
  const VideoListRouteArgs({
    this.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,
    this.videoListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<VideoViewModel>? preselectedItems;

  final VideoListBloc? videoListBloc;

  final String? ofSearch;

  final String? ofArtistId;

  final String? ofDanceId;

  final String? ofFigureId;

  @override
  String toString() {
    return 'VideoListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, videoListBloc: $videoListBloc, ofSearch: $ofSearch, ofArtistId: $ofArtistId, ofDanceId: $ofDanceId, ofFigureId: $ofFigureId}';
  }
}
