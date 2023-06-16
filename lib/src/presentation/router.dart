import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/${AppPaths.kPathHome}',
      page: MainRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathSettings}',
      page: SettingsRoute.page,
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/${AppPaths.kPathHome}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathArtists}',
      page: ArtistListRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathArtists}/${AppPaths.kViewCreate}',
      page: ArtistCreateRoute.page,
    ),
    RedirectRoute(
      path: '/${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}',
      redirectTo: '${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewDetails}',
      page: ArtistDetailsRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathArtists}/:${AppPaths.kParamArtistId}/${AppPaths.kViewEdit}',
      page: ArtistEditRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathDances}',
      page: DanceListRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathDances}/${AppPaths.kViewCreate}',
      page: DanceCreateRoute.page,
    ),
    RedirectRoute(
      path: '/${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}',
      redirectTo: '${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewDetails}',
      page: DanceDetailsRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewEdit}',
      page: DanceEditRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathFigures}',
      page: FigureListRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathFigures}/${AppPaths.kViewCreate}',
      page: FigureCreateRoute.page,
    ),
    RedirectRoute(
      path: '/${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}',
      redirectTo: '${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewDetails}',
      page: FigureDetailsRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewEdit}',
      page: FigureEditRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathPractices}',
      page: PracticeListRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathPractices}/${AppPaths.kViewCreate}',
      page: PracticeCreateRoute.page,
    ),
    RedirectRoute(
      path: '/${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}',
      redirectTo: '${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewDetails}',
      page: PracticeDetailsRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewEdit}',
      page: PracticeEditRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathVideos}',
      page: VideoListRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathVideos}/${AppPaths.kViewCreate}',
      page: VideoCreateRoute.page,
    ),
    RedirectRoute(
      path: '/${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}',
      redirectTo: '${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path: '/${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewDetails}',
      page: VideoDetailsRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathVideos}/:${AppPaths.kParamVideoId}/${AppPaths.kViewEdit}',
      page: VideoEditRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathMoments}/${AppPaths.kViewCreate}',
      page: MomentCreateRoute.page,
    ),
    AutoRoute(
      path: '/${AppPaths.kPathMoments}/:${AppPaths.kParamMomentId}/${AppPaths.kViewEdit}',
      page: MomentEditRoute.page,
    ),
  ];
}
