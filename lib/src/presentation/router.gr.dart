// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MainRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const MainPage());
    },
    SettingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const SettingsPage());
    },
    ArtistListRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistListRouteArgs>(
          orElse: () => const ArtistListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ArtistListPage(
              key: args.key,
              showAppBar: args.showAppBar,
              artistListBloc: args.artistListBloc,
              ofDance: args.ofDance,
              ofFigure: args.ofFigure,
              ofVideo: args.ofVideo));
    },
    ArtistCreateRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistCreateRouteArgs>(
          orElse: () => const ArtistCreateRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: ArtistCreatePage(key: args.key));
    },
    ArtistDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ArtistDetailsPage(key: args.key, artistId: args.artistId));
    },
    ArtistEditRoute.name: (routeData) {
      final args = routeData.argsAs<ArtistEditRouteArgs>(
          orElse: () => const ArtistEditRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: ArtistEditPage(key: args.key, artistId: args.artistId));
    },
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(
          orElse: () => const DanceListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: DanceListPage(
              key: args.key,
              showAppBar: args.showAppBar,
              danceListBloc: args.danceListBloc,
              ofArtist: args.ofArtist,
              ofVideo: args.ofVideo));
    },
    DanceCreateRoute.name: (routeData) {
      final args = routeData.argsAs<DanceCreateRouteArgs>(
          orElse: () => const DanceCreateRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: DanceCreatePage(key: args.key));
    },
    DanceDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<DanceDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: DanceDetailsPage(key: args.key, danceId: args.danceId));
    },
    DanceEditRoute.name: (routeData) {
      final args = routeData.argsAs<DanceEditRouteArgs>(
          orElse: () => const DanceEditRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: DanceEditPage(key: args.key, danceId: args.danceId));
    },
    FigureListRoute.name: (routeData) {
      final args = routeData.argsAs<FigureListRouteArgs>(
          orElse: () => const FigureListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: FigureListPage(
              key: args.key,
              showAppBar: args.showAppBar,
              figureListBloc: args.figureListBloc,
              ofArtist: args.ofArtist,
              ofDance: args.ofDance,
              ofVideo: args.ofVideo));
    },
    FigureCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const FigureCreatePage());
    },
    FigureDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<FigureDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: FigureDetailsPage(key: args.key, figureId: args.figureId));
    },
    FigureEditRoute.name: (routeData) {
      final args = routeData.argsAs<FigureEditRouteArgs>(
          orElse: () => const FigureEditRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: FigureEditPage(
              key: args.key,
              figureBloc: args.figureBloc,
              figureId: args.figureId));
    },
    PracticeListRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeListRouteArgs>(
          orElse: () => const PracticeListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PracticeListPage(
              key: args.key,
              showAppBar: args.showAppBar,
              practiceListBloc: args.practiceListBloc,
              ofArtist: args.ofArtist,
              ofDance: args.ofDance,
              ofFigure: args.ofFigure,
              ofVideo: args.ofVideo));
    },
    PracticeCreateRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeCreateRouteArgs>(
          orElse: () => const PracticeCreateRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: PracticeCreatePage(key: args.key));
    },
    PracticeDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              PracticeDetailsPage(key: args.key, practiceId: args.practiceId));
    },
    PracticeEditRoute.name: (routeData) {
      final args = routeData.argsAs<PracticeEditRouteArgs>(
          orElse: () => const PracticeEditRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: PracticeEditPage(key: args.key, practiceId: args.practiceId));
    },
    VideoListRoute.name: (routeData) {
      final args = routeData.argsAs<VideoListRouteArgs>(
          orElse: () => const VideoListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: VideoListPage(
              key: args.key,
              showAppBar: args.showAppBar,
              videoListBloc: args.videoListBloc,
              ofArtist: args.ofArtist,
              ofDance: args.ofDance,
              ofFigure: args.ofFigure));
    },
    VideoCreateRoute.name: (routeData) {
      final args = routeData.argsAs<VideoCreateRouteArgs>(
          orElse: () => const VideoCreateRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: VideoCreatePage(key: args.key));
    },
    VideoDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<VideoDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: VideoDetailsPage(key: args.key, videoId: args.videoId));
    },
    VideoEditRoute.name: (routeData) {
      final args = routeData.argsAs<VideoEditRouteArgs>(
          orElse: () => const VideoEditRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: VideoEditPage(key: args.key, videoId: args.videoId));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: 'home', fullMatch: true),
        RouteConfig(MainRoute.name, path: 'home'),
        RouteConfig(SettingsRoute.name, path: 'settings'),
        RouteConfig('*#redirect',
            path: '*', redirectTo: 'home', fullMatch: true),
        RouteConfig(ArtistListRoute.name, path: 'artists'),
        RouteConfig(ArtistCreateRoute.name, path: 'artists/create'),
        RouteConfig('artists/:artistId#redirect',
            path: 'artists/:artistId',
            redirectTo: 'artists/:artistId/details',
            fullMatch: true),
        RouteConfig(ArtistDetailsRoute.name, path: 'artists/:artistId/details'),
        RouteConfig(ArtistEditRoute.name, path: 'artists/:artistId/edit'),
        RouteConfig(DanceListRoute.name, path: 'dances'),
        RouteConfig(DanceCreateRoute.name, path: 'dances/create'),
        RouteConfig('dances/:danceId#redirect',
            path: 'dances/:danceId',
            redirectTo: 'dances/:danceId/details',
            fullMatch: true),
        RouteConfig(DanceDetailsRoute.name, path: 'dances/:danceId/details'),
        RouteConfig(DanceEditRoute.name, path: 'dances/:danceId/edit'),
        RouteConfig(FigureListRoute.name, path: 'figures'),
        RouteConfig(FigureCreateRoute.name, path: 'figures/create'),
        RouteConfig('figures/:figureId#redirect',
            path: 'figures/:figureId',
            redirectTo: 'figures/:figureId/details',
            fullMatch: true),
        RouteConfig(FigureDetailsRoute.name, path: 'figures/:figureId/details'),
        RouteConfig(FigureEditRoute.name, path: 'figures/:figureId/edit'),
        RouteConfig(PracticeListRoute.name, path: 'practices'),
        RouteConfig(PracticeCreateRoute.name, path: 'practices/create'),
        RouteConfig('practices/:practiceId#redirect',
            path: 'practices/:practiceId',
            redirectTo: 'practices/:practiceId/details',
            fullMatch: true),
        RouteConfig(PracticeDetailsRoute.name,
            path: 'practices/:practiceId/details'),
        RouteConfig(PracticeEditRoute.name, path: 'practices/:practiceId/edit'),
        RouteConfig(VideoListRoute.name, path: 'videos'),
        RouteConfig(VideoCreateRoute.name, path: 'videos/create'),
        RouteConfig('videos/:videoId#redirect',
            path: 'videos/:videoId',
            redirectTo: 'videos/:videoId/details',
            fullMatch: true),
        RouteConfig(VideoDetailsRoute.name, path: 'videos/:videoId/details'),
        RouteConfig(VideoEditRoute.name, path: 'videos/:videoId/edit'),
        RouteConfig(DanceListRoute.name, path: 'dances')
      ];
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute() : super(MainRoute.name, path: 'home');

  static const String name = 'MainRoute';
}

/// generated route for
/// [SettingsPage]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: 'settings');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [ArtistListPage]
class ArtistListRoute extends PageRouteInfo<ArtistListRouteArgs> {
  ArtistListRoute(
      {Key? key,
      bool showAppBar = true,
      ArtistListBloc? artistListBloc,
      String? ofDance,
      String? ofFigure,
      String? ofVideo})
      : super(ArtistListRoute.name,
            path: 'artists',
            args: ArtistListRouteArgs(
                key: key,
                showAppBar: showAppBar,
                artistListBloc: artistListBloc,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo));

  static const String name = 'ArtistListRoute';
}

class ArtistListRouteArgs {
  const ArtistListRouteArgs(
      {this.key,
      this.showAppBar = true,
      this.artistListBloc,
      this.ofDance,
      this.ofFigure,
      this.ofVideo});

  final Key? key;

  final bool showAppBar;

  final ArtistListBloc? artistListBloc;

  final String? ofDance;

  final String? ofFigure;

  final String? ofVideo;

  @override
  String toString() {
    return 'ArtistListRouteArgs{key: $key, showAppBar: $showAppBar, artistListBloc: $artistListBloc, ofDance: $ofDance, ofFigure: $ofFigure, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [ArtistCreatePage]
class ArtistCreateRoute extends PageRouteInfo<ArtistCreateRouteArgs> {
  ArtistCreateRoute({Key? key})
      : super(ArtistCreateRoute.name,
            path: 'artists/create', args: ArtistCreateRouteArgs(key: key));

  static const String name = 'ArtistCreateRoute';
}

class ArtistCreateRouteArgs {
  const ArtistCreateRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ArtistCreateRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ArtistDetailsPage]
class ArtistDetailsRoute extends PageRouteInfo<ArtistDetailsRouteArgs> {
  ArtistDetailsRoute({Key? key, required String artistId})
      : super(ArtistDetailsRoute.name,
            path: 'artists/:artistId/details',
            args: ArtistDetailsRouteArgs(key: key, artistId: artistId));

  static const String name = 'ArtistDetailsRoute';
}

class ArtistDetailsRouteArgs {
  const ArtistDetailsRouteArgs({this.key, required this.artistId});

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
  ArtistEditRoute({Key? key, String? artistId})
      : super(ArtistEditRoute.name,
            path: 'artists/:artistId/edit',
            args: ArtistEditRouteArgs(key: key, artistId: artistId));

  static const String name = 'ArtistEditRoute';
}

class ArtistEditRouteArgs {
  const ArtistEditRouteArgs({this.key, this.artistId});

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
  DanceListRoute(
      {Key? key,
      bool showAppBar = true,
      DanceListBloc? danceListBloc,
      String? ofArtist,
      String? ofVideo})
      : super(DanceListRoute.name,
            path: 'dances',
            args: DanceListRouteArgs(
                key: key,
                showAppBar: showAppBar,
                danceListBloc: danceListBloc,
                ofArtist: ofArtist,
                ofVideo: ofVideo));

  static const String name = 'DanceListRoute';
}

class DanceListRouteArgs {
  const DanceListRouteArgs(
      {this.key,
      this.showAppBar = true,
      this.danceListBloc,
      this.ofArtist,
      this.ofVideo});

  final Key? key;

  final bool showAppBar;

  final DanceListBloc? danceListBloc;

  final String? ofArtist;

  final String? ofVideo;

  @override
  String toString() {
    return 'DanceListRouteArgs{key: $key, showAppBar: $showAppBar, danceListBloc: $danceListBloc, ofArtist: $ofArtist, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [DanceCreatePage]
class DanceCreateRoute extends PageRouteInfo<DanceCreateRouteArgs> {
  DanceCreateRoute({Key? key})
      : super(DanceCreateRoute.name,
            path: 'dances/create', args: DanceCreateRouteArgs(key: key));

  static const String name = 'DanceCreateRoute';
}

class DanceCreateRouteArgs {
  const DanceCreateRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'DanceCreateRouteArgs{key: $key}';
  }
}

/// generated route for
/// [DanceDetailsPage]
class DanceDetailsRoute extends PageRouteInfo<DanceDetailsRouteArgs> {
  DanceDetailsRoute({Key? key, required String danceId})
      : super(DanceDetailsRoute.name,
            path: 'dances/:danceId/details',
            args: DanceDetailsRouteArgs(key: key, danceId: danceId));

  static const String name = 'DanceDetailsRoute';
}

class DanceDetailsRouteArgs {
  const DanceDetailsRouteArgs({this.key, required this.danceId});

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
  DanceEditRoute({Key? key, String? danceId})
      : super(DanceEditRoute.name,
            path: 'dances/:danceId/edit',
            args: DanceEditRouteArgs(key: key, danceId: danceId));

  static const String name = 'DanceEditRoute';
}

class DanceEditRouteArgs {
  const DanceEditRouteArgs({this.key, this.danceId});

  final Key? key;

  final String? danceId;

  @override
  String toString() {
    return 'DanceEditRouteArgs{key: $key, danceId: $danceId}';
  }
}

/// generated route for
/// [FigureListPage]
class FigureListRoute extends PageRouteInfo<FigureListRouteArgs> {
  FigureListRoute(
      {Key? key,
      bool showAppBar = true,
      FigureListBloc? figureListBloc,
      String? ofArtist,
      String? ofDance,
      String? ofVideo})
      : super(FigureListRoute.name,
            path: 'figures',
            args: FigureListRouteArgs(
                key: key,
                showAppBar: showAppBar,
                figureListBloc: figureListBloc,
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofVideo: ofVideo));

  static const String name = 'FigureListRoute';
}

class FigureListRouteArgs {
  const FigureListRouteArgs(
      {this.key,
      this.showAppBar = true,
      this.figureListBloc,
      this.ofArtist,
      this.ofDance,
      this.ofVideo});

  final Key? key;

  final bool showAppBar;

  final FigureListBloc? figureListBloc;

  final String? ofArtist;

  final String? ofDance;

  final String? ofVideo;

  @override
  String toString() {
    return 'FigureListRouteArgs{key: $key, showAppBar: $showAppBar, figureListBloc: $figureListBloc, ofArtist: $ofArtist, ofDance: $ofDance, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [FigureCreatePage]
class FigureCreateRoute extends PageRouteInfo<void> {
  const FigureCreateRoute()
      : super(FigureCreateRoute.name, path: 'figures/create');

  static const String name = 'FigureCreateRoute';
}

/// generated route for
/// [FigureDetailsPage]
class FigureDetailsRoute extends PageRouteInfo<FigureDetailsRouteArgs> {
  FigureDetailsRoute({Key? key, required String figureId})
      : super(FigureDetailsRoute.name,
            path: 'figures/:figureId/details',
            args: FigureDetailsRouteArgs(key: key, figureId: figureId));

  static const String name = 'FigureDetailsRoute';
}

class FigureDetailsRouteArgs {
  const FigureDetailsRouteArgs({this.key, required this.figureId});

  final Key? key;

  final String figureId;

  @override
  String toString() {
    return 'FigureDetailsRouteArgs{key: $key, figureId: $figureId}';
  }
}

/// generated route for
/// [FigureEditPage]
class FigureEditRoute extends PageRouteInfo<FigureEditRouteArgs> {
  FigureEditRoute({Key? key, FigureDetailBloc? figureBloc, String? figureId})
      : super(FigureEditRoute.name,
            path: 'figures/:figureId/edit',
            args: FigureEditRouteArgs(
                key: key, figureBloc: figureBloc, figureId: figureId));

  static const String name = 'FigureEditRoute';
}

class FigureEditRouteArgs {
  const FigureEditRouteArgs({this.key, this.figureBloc, this.figureId});

  final Key? key;

  final FigureDetailBloc? figureBloc;

  final String? figureId;

  @override
  String toString() {
    return 'FigureEditRouteArgs{key: $key, figureBloc: $figureBloc, figureId: $figureId}';
  }
}

/// generated route for
/// [PracticeListPage]
class PracticeListRoute extends PageRouteInfo<PracticeListRouteArgs> {
  PracticeListRoute(
      {Key? key,
      bool showAppBar = true,
      PracticeListBloc? practiceListBloc,
      String? ofArtist,
      String? ofDance,
      String? ofFigure,
      String? ofVideo})
      : super(PracticeListRoute.name,
            path: 'practices',
            args: PracticeListRouteArgs(
                key: key,
                showAppBar: showAppBar,
                practiceListBloc: practiceListBloc,
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo));

  static const String name = 'PracticeListRoute';
}

class PracticeListRouteArgs {
  const PracticeListRouteArgs(
      {this.key,
      this.showAppBar = true,
      this.practiceListBloc,
      this.ofArtist,
      this.ofDance,
      this.ofFigure,
      this.ofVideo});

  final Key? key;

  final bool showAppBar;

  final PracticeListBloc? practiceListBloc;

  final String? ofArtist;

  final String? ofDance;

  final String? ofFigure;

  final String? ofVideo;

  @override
  String toString() {
    return 'PracticeListRouteArgs{key: $key, showAppBar: $showAppBar, practiceListBloc: $practiceListBloc, ofArtist: $ofArtist, ofDance: $ofDance, ofFigure: $ofFigure, ofVideo: $ofVideo}';
  }
}

/// generated route for
/// [PracticeCreatePage]
class PracticeCreateRoute extends PageRouteInfo<PracticeCreateRouteArgs> {
  PracticeCreateRoute({Key? key})
      : super(PracticeCreateRoute.name,
            path: 'practices/create', args: PracticeCreateRouteArgs(key: key));

  static const String name = 'PracticeCreateRoute';
}

class PracticeCreateRouteArgs {
  const PracticeCreateRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'PracticeCreateRouteArgs{key: $key}';
  }
}

/// generated route for
/// [PracticeDetailsPage]
class PracticeDetailsRoute extends PageRouteInfo<PracticeDetailsRouteArgs> {
  PracticeDetailsRoute({Key? key, required String practiceId})
      : super(PracticeDetailsRoute.name,
            path: 'practices/:practiceId/details',
            args: PracticeDetailsRouteArgs(key: key, practiceId: practiceId));

  static const String name = 'PracticeDetailsRoute';
}

class PracticeDetailsRouteArgs {
  const PracticeDetailsRouteArgs({this.key, required this.practiceId});

  final Key? key;

  final String practiceId;

  @override
  String toString() {
    return 'PracticeDetailsRouteArgs{key: $key, practiceId: $practiceId}';
  }
}

/// generated route for
/// [PracticeEditPage]
class PracticeEditRoute extends PageRouteInfo<PracticeEditRouteArgs> {
  PracticeEditRoute({Key? key, String? practiceId})
      : super(PracticeEditRoute.name,
            path: 'practices/:practiceId/edit',
            args: PracticeEditRouteArgs(key: key, practiceId: practiceId));

  static const String name = 'PracticeEditRoute';
}

class PracticeEditRouteArgs {
  const PracticeEditRouteArgs({this.key, this.practiceId});

  final Key? key;

  final String? practiceId;

  @override
  String toString() {
    return 'PracticeEditRouteArgs{key: $key, practiceId: $practiceId}';
  }
}

/// generated route for
/// [VideoListPage]
class VideoListRoute extends PageRouteInfo<VideoListRouteArgs> {
  VideoListRoute(
      {Key? key,
      bool showAppBar = true,
      VideoListBloc? videoListBloc,
      String? ofArtist,
      String? ofDance,
      String? ofFigure})
      : super(VideoListRoute.name,
            path: 'videos',
            args: VideoListRouteArgs(
                key: key,
                showAppBar: showAppBar,
                videoListBloc: videoListBloc,
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure));

  static const String name = 'VideoListRoute';
}

class VideoListRouteArgs {
  const VideoListRouteArgs(
      {this.key,
      this.showAppBar = true,
      this.videoListBloc,
      this.ofArtist,
      this.ofDance,
      this.ofFigure});

  final Key? key;

  final bool showAppBar;

  final VideoListBloc? videoListBloc;

  final String? ofArtist;

  final String? ofDance;

  final String? ofFigure;

  @override
  String toString() {
    return 'VideoListRouteArgs{key: $key, showAppBar: $showAppBar, videoListBloc: $videoListBloc, ofArtist: $ofArtist, ofDance: $ofDance, ofFigure: $ofFigure}';
  }
}

/// generated route for
/// [VideoCreatePage]
class VideoCreateRoute extends PageRouteInfo<VideoCreateRouteArgs> {
  VideoCreateRoute({Key? key})
      : super(VideoCreateRoute.name,
            path: 'videos/create', args: VideoCreateRouteArgs(key: key));

  static const String name = 'VideoCreateRoute';
}

class VideoCreateRouteArgs {
  const VideoCreateRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'VideoCreateRouteArgs{key: $key}';
  }
}

/// generated route for
/// [VideoDetailsPage]
class VideoDetailsRoute extends PageRouteInfo<VideoDetailsRouteArgs> {
  VideoDetailsRoute({Key? key, required String videoId})
      : super(VideoDetailsRoute.name,
            path: 'videos/:videoId/details',
            args: VideoDetailsRouteArgs(key: key, videoId: videoId));

  static const String name = 'VideoDetailsRoute';
}

class VideoDetailsRouteArgs {
  const VideoDetailsRouteArgs({this.key, required this.videoId});

  final Key? key;

  final String videoId;

  @override
  String toString() {
    return 'VideoDetailsRouteArgs{key: $key, videoId: $videoId}';
  }
}

/// generated route for
/// [VideoEditPage]
class VideoEditRoute extends PageRouteInfo<VideoEditRouteArgs> {
  VideoEditRoute({Key? key, String? videoId})
      : super(VideoEditRoute.name,
            path: 'videos/:videoId/edit',
            args: VideoEditRouteArgs(key: key, videoId: videoId));

  static const String name = 'VideoEditRoute';
}

class VideoEditRouteArgs {
  const VideoEditRouteArgs({this.key, this.videoId});

  final Key? key;

  final String? videoId;

  @override
  String toString() {
    return 'VideoEditRouteArgs{key: $key, videoId: $videoId}';
  }
}
