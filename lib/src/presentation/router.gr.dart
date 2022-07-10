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
      final args = routeData.argsAs<SettingsRouteArgs>(
          orElse: () => const SettingsRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: SettingsPage(key: args.key));
    },
    ArtistListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ArtistListPage());
    },
    ArtistCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ArtistCreatePage());
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
          child: ArtistEditPage(
              key: args.key,
              artistBloc: args.artistBloc,
              artistId: args.artistId));
    },
    FigureListRoute.name: (routeData) {
      final args = routeData.argsAs<FigureListRouteArgs>(
          orElse: () => const FigureListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: FigureListPage(key: args.key));
    },
    VideoListRoute.name: (routeData) {
      final args = routeData.argsAs<VideoListRouteArgs>(
          orElse: () => const VideoListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: VideoListPage(key: args.key));
    },
    VideoCreateRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const VideoCreatePage());
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
          child: VideoEditPage(
              key: args.key, videoBloc: args.videoBloc, videoId: args.videoId));
    },
    DanceListRoute.name: (routeData) {
      final args = routeData.argsAs<DanceListRouteArgs>(
          orElse: () => const DanceListRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData, child: DanceListPage(key: args.key));
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
        RouteConfig(FigureListRoute.name, path: 'figures'),
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
class SettingsRoute extends PageRouteInfo<SettingsRouteArgs> {
  SettingsRoute({Key? key})
      : super(SettingsRoute.name,
            path: 'settings', args: SettingsRouteArgs(key: key));

  static const String name = 'SettingsRoute';
}

class SettingsRouteArgs {
  const SettingsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SettingsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ArtistListPage]
class ArtistListRoute extends PageRouteInfo<void> {
  const ArtistListRoute() : super(ArtistListRoute.name, path: 'artists');

  static const String name = 'ArtistListRoute';
}

/// generated route for
/// [ArtistCreatePage]
class ArtistCreateRoute extends PageRouteInfo<void> {
  const ArtistCreateRoute()
      : super(ArtistCreateRoute.name, path: 'artists/create');

  static const String name = 'ArtistCreateRoute';
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
  ArtistEditRoute({Key? key, ArtistBloc? artistBloc, String? artistId})
      : super(ArtistEditRoute.name,
            path: 'artists/:artistId/edit',
            args: ArtistEditRouteArgs(
                key: key, artistBloc: artistBloc, artistId: artistId));

  static const String name = 'ArtistEditRoute';
}

class ArtistEditRouteArgs {
  const ArtistEditRouteArgs({this.key, this.artistBloc, this.artistId});

  final Key? key;

  final ArtistBloc? artistBloc;

  final String? artistId;

  @override
  String toString() {
    return 'ArtistEditRouteArgs{key: $key, artistBloc: $artistBloc, artistId: $artistId}';
  }
}

/// generated route for
/// [FigureListPage]
class FigureListRoute extends PageRouteInfo<FigureListRouteArgs> {
  FigureListRoute({Key? key})
      : super(FigureListRoute.name,
            path: 'figures', args: FigureListRouteArgs(key: key));

  static const String name = 'FigureListRoute';
}

class FigureListRouteArgs {
  const FigureListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'FigureListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [VideoListPage]
class VideoListRoute extends PageRouteInfo<VideoListRouteArgs> {
  VideoListRoute({Key? key})
      : super(VideoListRoute.name,
            path: 'videos', args: VideoListRouteArgs(key: key));

  static const String name = 'VideoListRoute';
}

class VideoListRouteArgs {
  const VideoListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'VideoListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [VideoCreatePage]
class VideoCreateRoute extends PageRouteInfo<void> {
  const VideoCreateRoute()
      : super(VideoCreateRoute.name, path: 'videos/create');

  static const String name = 'VideoCreateRoute';
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
  VideoEditRoute({Key? key, VideoBloc? videoBloc, String? videoId})
      : super(VideoEditRoute.name,
            path: 'videos/:videoId/edit',
            args: VideoEditRouteArgs(
                key: key, videoBloc: videoBloc, videoId: videoId));

  static const String name = 'VideoEditRoute';
}

class VideoEditRouteArgs {
  const VideoEditRouteArgs({this.key, this.videoBloc, this.videoId});

  final Key? key;

  final VideoBloc? videoBloc;

  final String? videoId;

  @override
  String toString() {
    return 'VideoEditRouteArgs{key: $key, videoBloc: $videoBloc, videoId: $videoId}';
  }
}

/// generated route for
/// [DanceListPage]
class DanceListRoute extends PageRouteInfo<DanceListRouteArgs> {
  DanceListRoute({Key? key})
      : super(DanceListRoute.name,
            path: 'dances', args: DanceListRouteArgs(key: key));

  static const String name = 'DanceListRoute';
}

class DanceListRouteArgs {
  const DanceListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'DanceListRouteArgs{key: $key}';
  }
}
