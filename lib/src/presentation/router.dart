import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page|Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(path: AppPaths.kPathHome, page: MainPage, initial: true),
    AutoRoute(path: AppPaths.kPathSettings, page: SettingsPage),
    RedirectRoute(path: '*', redirectTo: AppPaths.kPathHome),

    /// Artists
    AutoRoute(
      path: AppPaths.kPathArtists,
      page: ArtistListPage,
    ),
    AutoRoute(
      path: '${AppPaths.kPathArtists}/${AppPaths.kViewCreate}',
      page: ArtistCreatePage,
    ),
    RedirectRoute(
      path: '${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}',
      redirectTo:
          '${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewDetails}',
      page: ArtistDetailsPage,
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewEdit}',
      page: ArtistEditPage,
    ),

    /// Figures
    AutoRoute(
      path: AppPaths.kPathFigures,
      page: FigureListPage,
    ),

    /// Videos
    AutoRoute(
      path: AppPaths.kPathVideos,
      page: VideoListPage,
    ),
    AutoRoute(
      path: '${AppPaths.kPathVideos}/${AppPaths.kViewCreate}',
      page: VideoCreatePage,
    ),
    RedirectRoute(
      path: '${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}',
      redirectTo:
      '${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path:
      '${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewDetails}',
      page: VideoDetailsPage,
    ),
    AutoRoute(
      path:
      '${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewEdit}',
      page: VideoEditPage,
    ),

    /// Dances
    AutoRoute(
      path: AppPaths.kPathDances,
      page: DanceListPage,
    ),
  ],
)
class AppRouter extends _$AppRouter {
  final String _tag = '$AppRouter';
}
