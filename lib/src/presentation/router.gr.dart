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
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
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
<<<<<<< HEAD
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
    ArtistCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ArtistCreatePage()),
      );
    },
    ArtistDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistDetailsPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    ArtistEditRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistEditRouteArgs>(
          orElse: () => const ArtistEditRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistEditPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(
          orElse: () => const DanceListRouteArgs());
      return MaterialPageX<List<DanceViewModel>>(
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
          ofArtist: args.ofArtist,
          ofVideo: args.ofVideo,
        ),
      );
    },
    DanceCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DanceCreatePage()),
      );
    },
    DanceDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DanceDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceDetailsPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
    DanceEditRoute.name: (routeData) {
      final args = routeData.argsAs<DanceEditRouteArgs>(
          orElse: () => const DanceEditRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceEditPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
=======
    ArtistCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ArtistCreatePage()),
      );
    },
    ArtistDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistDetailsPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    ArtistEditRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistEditRouteArgs>(
          orElse: () => const ArtistEditRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistEditPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(
          orElse: () => const DanceListRouteArgs());
      return MaterialPageX<List<DanceViewModel>>(
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
    DanceCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DanceCreatePage()),
      );
    },
    DanceDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DanceDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceDetailsPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
    DanceEditRoute.name: (routeData) {
      final args = routeData.argsAs<DanceEditRouteArgs>(
          orElse: () => const DanceEditRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceEditPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
    FigureListRoute.name: (routeData) {
      final args = routeData.argsAs<FigureListRouteArgs>(
          orElse: () => const FigureListRouteArgs());
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
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(
          orElse: () => const DanceListRouteArgs());
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
          ofArtist: args.ofArtist,
          ofVideo: args.ofVideo,
        ),
      );
    },
    PracticeDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PracticeDetailsRouteArgs>(
          orElse: () => PracticeDetailsRouteArgs(
              practiceId: pathParams.getString('practiceId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: PracticeDetailsPage(
          key: args.key,
          practiceId: args.practiceId,
        )),
      );
    },
    PracticeCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const PracticeCreatePage()),
      );
    },
    PracticeEditRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeEditRouteArgs>(
          orElse: () => const PracticeEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: PracticeEditPage(
          key: args.key,
          practiceId: args.practiceId,
        )),
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
          orElse: () =>
              MomentEditRouteArgs(momentId: pathParams.optString('momentId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: MomentEditPage(
          key: args.key,
          momentId: args.momentId,
        )),
      );
    },
    ArtistDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ArtistDetailsRouteArgs>(
          orElse: () => ArtistDetailsRouteArgs(
              artistId: pathParams.getString('artistId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistDetailsPage(
          key: args.key,
          artistId: args.artistId,
        )),
      );
    },
    ArtistCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const ArtistCreatePage()),
      );
    },
    ArtistEditRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistEditRouteArgs>(
          orElse: () => const ArtistEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArtistEditPage(
          key: args.key,
          artistId: args.artistId,
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
    FigureDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<FigureDetailsRouteArgs>(
          orElse: () => FigureDetailsRouteArgs(
              figureId: pathParams.getString('figureId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: FigureDetailsPage(
          key: args.key,
          figureId: args.figureId,
        )),
      );
    },
    FigureCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const FigureCreatePage()),
      );
    },
    FigureEditRoute.name: (routeData) {
      final args = routeData.argsAs<FigureEditRouteArgs>(
          orElse: () => const FigureEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: FigureEditPage(
          key: args.key,
          figureId: args.figureId,
        )),
      );
    },
    DanceDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<DanceDetailsRouteArgs>(
          orElse: () =>
              DanceDetailsRouteArgs(danceId: pathParams.getString('danceId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceDetailsPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
    DanceCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const DanceCreatePage()),
      );
    },
    DanceEditRoute.name: (routeData) {
      final args = routeData.argsAs<DanceEditRouteArgs>(
          orElse: () => const DanceEditRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: DanceEditPage(
          key: args.key,
          danceId: args.danceId,
        )),
      );
    },
    VideoDetailsRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<VideoDetailsRouteArgs>(
          orElse: () =>
              VideoDetailsRouteArgs(videoId: pathParams.getString('videoId')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: VideoDetailsPage(
          key: args.key,
          videoId: args.videoId,
        )),
      );
    },
    VideoCreateRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(child: const VideoCreatePage()),
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
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };
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
<<<<<<< HEAD
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<PageRouteInfo>? children,
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
=======
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
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
<<<<<<< HEAD
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
/// [ArtistCreatePage]
class ArtistCreateRoute extends PageRouteInfo<void> {
  const ArtistCreateRoute()
      : super(
          ArtistCreateRoute.name,
          path: 'artists/create',
        );

  static const String name = 'ArtistCreateRoute';
}

/// generated route for
/// [ArtistDetailsPage]
class ArtistDetailsRoute extends PageRouteInfo<ArtistDetailsRouteArgs> {
  ArtistDetailsRoute({
    Key? key,
    required String artistId,
  }) : super(
          ArtistDetailsRoute.name,
          path: 'artists/:artistId/details',
          args: ArtistDetailsRouteArgs(
            key: key,
            artistId: artistId,
          ),
        );

  static const String name = 'ArtistDetailsRoute';
}

class ArtistDetailsRouteArgs {
  const ArtistDetailsRouteArgs({
    this.key,
    required this.artistId,
  });

  final Key? key;

  final String artistId;

  @override
  String toString() {
    return 'ArtistDetailsRouteArgs{key: $key, artistId: $artistId}';
  }
}

/// generated route for
/// [ArtistEditPage]
class ArtistEditRoute extends PageRouteInfo<ArtistEditRouteArgs> {
  ArtistEditRoute({
    Key? key,
    String? artistId,
  }) : super(
          ArtistEditRoute.name,
          path: 'artists/:artistId/edit',
          args: ArtistEditRouteArgs(
            key: key,
            artistId: artistId,
          ),
        );

  static const String name = 'ArtistEditRoute';
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
    String? ofArtist,
    String? ofVideo,
  }) : super(
          DanceListRoute.name,
          path: 'dances',
          args: DanceListRouteArgs(
            key: key,
            showAppBar: showAppBar,
            titleText: titleText,
            shouldSelectOne: shouldSelectOne,
            shouldSelectMultiple: shouldSelectMultiple,
            preselectedItems: preselectedItems,
            danceListBloc: danceListBloc,
            ofSearch: ofSearch,
            ofArtist: ofArtist,
            ofVideo: ofVideo,
          ),
        );

  static const String name = 'DanceListRoute';
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
    this.ofArtist,
    this.ofVideo,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<DanceViewModel>? preselectedItems;

  final DanceListBloc? danceListBloc;

  final String? ofSearch;

  final String? ofArtist;

  final String? ofVideo;

  @override
  String toString() {
    return 'DanceListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, danceListBloc: $danceListBloc, ofSearch: $ofSearch, ofArtist: $ofArtist, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [DanceCreatePage]
class DanceCreateRoute extends PageRouteInfo<void> {
  const DanceCreateRoute()
      : super(
          DanceCreateRoute.name,
          path: 'dances/create',
        );

  static const String name = 'DanceCreateRoute';
}

/// generated route for
/// [DanceDetailsPage]
class DanceDetailsRoute extends PageRouteInfo<DanceDetailsRouteArgs> {
  DanceDetailsRoute({
    Key? key,
    required String danceId,
  }) : super(
          DanceDetailsRoute.name,
          path: 'dances/:danceId/details',
          args: DanceDetailsRouteArgs(
            key: key,
            danceId: danceId,
          ),
        );

  static const String name = 'DanceDetailsRoute';
}

class DanceDetailsRouteArgs {
  const DanceDetailsRouteArgs({
    this.key,
    required this.danceId,
  });

  final Key? key;

  final String danceId;

  @override
  String toString() {
    return 'DanceDetailsRouteArgs{key: $key, danceId: $danceId}';
  }
}

/// generated route for
/// [DanceEditPage]
class DanceEditRoute extends PageRouteInfo<DanceEditRouteArgs> {
  DanceEditRoute({
    Key? key,
    String? danceId,
  }) : super(
          DanceEditRoute.name,
          path: 'dances/:danceId/edit',
          args: DanceEditRouteArgs(
            key: key,
            danceId: danceId,
          ),
        );

  static const String name = 'DanceEditRoute';
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
=======
/// [ArtistCreatePage]
class ArtistCreateRoute extends PageRouteInfo<void> {
  const ArtistCreateRoute()
      : super(
          ArtistCreateRoute.name,
          path: 'artists/create',
        );

  static const String name = 'ArtistCreateRoute';
}

/// generated route for
/// [ArtistDetailsPage]
class ArtistDetailsRoute extends PageRouteInfo<ArtistDetailsRouteArgs> {
  ArtistDetailsRoute({
    Key? key,
    required String artistId,
  }) : super(
          ArtistDetailsRoute.name,
          path: 'artists/:artistId/details',
          args: ArtistDetailsRouteArgs(
            key: key,
            artistId: artistId,
          ),
        );

  static const String name = 'ArtistDetailsRoute';
}

class ArtistDetailsRouteArgs {
  const ArtistDetailsRouteArgs({
    this.key,
    required this.artistId,
  });

  final Key? key;

  final String artistId;

  @override
  String toString() {
    return 'ArtistDetailsRouteArgs{key: $key, artistId: $artistId}';
  }
}

/// generated route for
/// [ArtistEditPage]
class ArtistEditRoute extends PageRouteInfo<ArtistEditRouteArgs> {
  ArtistEditRoute({
    Key? key,
    String? artistId,
  }) : super(
          ArtistEditRoute.name,
          path: 'artists/:artistId/edit',
          args: ArtistEditRouteArgs(
            key: key,
            artistId: artistId,
          ),
        );

  static const String name = 'ArtistEditRoute';
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
  }) : super(
          DanceListRoute.name,
          path: 'dances',
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
        );

  static const String name = 'DanceListRoute';
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
/// [DanceCreatePage]
class DanceCreateRoute extends PageRouteInfo<void> {
  const DanceCreateRoute()
      : super(
          DanceCreateRoute.name,
          path: 'dances/create',
        );

  static const String name = 'DanceCreateRoute';
}

/// generated route for
/// [DanceDetailsPage]
class DanceDetailsRoute extends PageRouteInfo<DanceDetailsRouteArgs> {
  DanceDetailsRoute({
    Key? key,
    required String danceId,
  }) : super(
          DanceDetailsRoute.name,
          path: 'dances/:danceId/details',
          args: DanceDetailsRouteArgs(
            key: key,
            danceId: danceId,
          ),
        );

  static const String name = 'DanceDetailsRoute';
}

class DanceDetailsRouteArgs {
  const DanceDetailsRouteArgs({
    this.key,
    required this.danceId,
  });

  final Key? key;

  final String danceId;

  @override
  String toString() {
    return 'DanceDetailsRouteArgs{key: $key, danceId: $danceId}';
  }
}

/// generated route for
/// [DanceEditPage]
class DanceEditRoute extends PageRouteInfo<DanceEditRouteArgs> {
  DanceEditRoute({
    Key? key,
    String? danceId,
  }) : super(
          DanceEditRoute.name,
          path: 'dances/:danceId/edit',
          args: DanceEditRouteArgs(
            key: key,
            danceId: danceId,
          ),
        );

  static const String name = 'DanceEditRoute';
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
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
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
<<<<<<< HEAD
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
    List<PageRouteInfo>? children,
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
=======
    String? ofArtistId,
    String? ofDanceId,
    String? ofVideoId,
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
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

  static const PageInfo<FigureListRouteArgs> page =
      PageInfo<FigureListRouteArgs>(name);
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
    String? ofArtist,
    String? ofVideo,
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
            ofArtist: ofArtist,
            ofVideo: ofVideo,
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
    this.ofArtist,
    this.ofVideo,
  });

  final Key? key;

  final bool showAppBar;

  final String? titleText;

  final bool shouldSelectOne;

  final bool shouldSelectMultiple;

  final List<DanceViewModel>? preselectedItems;

  final DanceListBloc? danceListBloc;

  final String? ofSearch;

  final String? ofArtist;

  final String? ofVideo;

  @override
  String toString() {
    return 'DanceListRouteArgs{key: $key, showAppBar: $showAppBar, titleText: $titleText, shouldSelectOne: $shouldSelectOne, shouldSelectMultiple: $shouldSelectMultiple, preselectedItems: $preselectedItems, danceListBloc: $danceListBloc, ofSearch: $ofSearch, ofArtist: $ofArtist, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [PracticeDetailsPage]
class PracticeDetailsRoute extends PageRouteInfo<PracticeDetailsRouteArgs> {
  PracticeDetailsRoute({
    Key? key,
    required String practiceId,
    List<PageRouteInfo>? children,
  }) : super(
          PracticeDetailsRoute.name,
          args: PracticeDetailsRouteArgs(
            key: key,
            practiceId: practiceId,
          ),
          rawPathParams: {'practiceId': practiceId},
          initialChildren: children,
        );

  static const String name = 'PracticeDetailsRoute';

  static const PageInfo<PracticeDetailsRouteArgs> page =
      PageInfo<PracticeDetailsRouteArgs>(name);
}

class PracticeDetailsRouteArgs {
  const PracticeDetailsRouteArgs({
    this.key,
    required this.practiceId,
  });

  final Key? key;

  final String practiceId;

  @override
  String toString() {
    return 'PracticeDetailsRouteArgs{key: $key, practiceId: $practiceId}';
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

  static const PageInfo<PracticeEditRouteArgs> page =
      PageInfo<PracticeEditRouteArgs>(name);
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
/// [ArtistDetailsPage]
class ArtistDetailsRoute extends PageRouteInfo<ArtistDetailsRouteArgs> {
  ArtistDetailsRoute({
    Key? key,
    required String artistId,
    List<PageRouteInfo>? children,
  }) : super(
          ArtistDetailsRoute.name,
          args: ArtistDetailsRouteArgs(
            key: key,
            artistId: artistId,
          ),
          rawPathParams: {'artistId': artistId},
          initialChildren: children,
        );

  static const String name = 'ArtistDetailsRoute';

  static const PageInfo<ArtistDetailsRouteArgs> page =
      PageInfo<ArtistDetailsRouteArgs>(name);
}

class ArtistDetailsRouteArgs {
  const ArtistDetailsRouteArgs({
    this.key,
    required this.artistId,
  });

  final Key? key;

  final String artistId;

  @override
  String toString() {
    return 'ArtistDetailsRouteArgs{key: $key, artistId: $artistId}';
  }
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

  static const PageInfo<ArtistEditRouteArgs> page =
      PageInfo<ArtistEditRouteArgs>(name);
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
<<<<<<< HEAD
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<PageRouteInfo>? children,
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
=======
    String? ofArtistId,
    String? ofDanceId,
    String? ofFigureId,
    String? ofVideoId,
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
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
/// [FigureDetailsPage]
class FigureDetailsRoute extends PageRouteInfo<FigureDetailsRouteArgs> {
  FigureDetailsRoute({
    Key? key,
    required String figureId,
    List<PageRouteInfo>? children,
  }) : super(
          FigureDetailsRoute.name,
          args: FigureDetailsRouteArgs(
            key: key,
            figureId: figureId,
          ),
          rawPathParams: {'figureId': figureId},
          initialChildren: children,
        );

  static const String name = 'FigureDetailsRoute';

  static const PageInfo<FigureDetailsRouteArgs> page =
      PageInfo<FigureDetailsRouteArgs>(name);
}

class FigureDetailsRouteArgs {
  const FigureDetailsRouteArgs({
    this.key,
    required this.figureId,
  });

  final Key? key;

  final String figureId;

  @override
  String toString() {
    return 'FigureDetailsRouteArgs{key: $key, figureId: $figureId}';
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

  static const PageInfo<FigureEditRouteArgs> page =
      PageInfo<FigureEditRouteArgs>(name);
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
/// [DanceDetailsPage]
class DanceDetailsRoute extends PageRouteInfo<DanceDetailsRouteArgs> {
  DanceDetailsRoute({
    Key? key,
    required String danceId,
    List<PageRouteInfo>? children,
  }) : super(
          DanceDetailsRoute.name,
          args: DanceDetailsRouteArgs(
            key: key,
            danceId: danceId,
          ),
          rawPathParams: {'danceId': danceId},
          initialChildren: children,
        );

  static const String name = 'DanceDetailsRoute';

  static const PageInfo<DanceDetailsRouteArgs> page =
      PageInfo<DanceDetailsRouteArgs>(name);
}

class DanceDetailsRouteArgs {
  const DanceDetailsRouteArgs({
    this.key,
    required this.danceId,
  });

  final Key? key;

  final String danceId;

  @override
  String toString() {
    return 'DanceDetailsRouteArgs{key: $key, danceId: $danceId}';
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

  static const PageInfo<DanceEditRouteArgs> page =
      PageInfo<DanceEditRouteArgs>(name);
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
/// [VideoDetailsPage]
class VideoDetailsRoute extends PageRouteInfo<VideoDetailsRouteArgs> {
  VideoDetailsRoute({
    Key? key,
    required String videoId,
    List<PageRouteInfo>? children,
  }) : super(
          VideoDetailsRoute.name,
          args: VideoDetailsRouteArgs(
            key: key,
            videoId: videoId,
          ),
          rawPathParams: {'videoId': videoId},
          initialChildren: children,
        );

  static const String name = 'VideoDetailsRoute';

  static const PageInfo<VideoDetailsRouteArgs> page =
      PageInfo<VideoDetailsRouteArgs>(name);
}

class VideoDetailsRouteArgs {
  const VideoDetailsRouteArgs({
    this.key,
    required this.videoId,
  });

  final Key? key;

  final String videoId;

  @override
  String toString() {
    return 'VideoDetailsRouteArgs{key: $key, videoId: $videoId}';
  }
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
<<<<<<< HEAD
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    List<PageRouteInfo>? children,
||||||| parent of 13f7c84 (Change id parameters name to be more explicit)
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
=======
    String? ofArtistId,
    String? ofDanceId,
    String? ofFigureId,
>>>>>>> 13f7c84 (Change id parameters name to be more explicit)
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
