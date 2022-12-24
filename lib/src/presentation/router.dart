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
    AutoRoute<List<ArtistViewModel>>(
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

    /// Dances
    AutoRoute<List<DanceViewModel>>(
      path: AppPaths.kPathDances,
      page: DanceListPage,
    ),
    AutoRoute(
      path: '${AppPaths.kPathDances}/${AppPaths.kViewCreate}',
      page: DanceCreatePage,
    ),
    RedirectRoute(
      path: '${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}',
      redirectTo:
          '${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewDetails}',
      page: DanceDetailsPage,
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathDances}/:${AppPaths.kParamDanceId}/${AppPaths.kViewEdit}',
      page: DanceEditPage,
    ),

    /// Figures
    AutoRoute<List<FigureViewModel>>(
      path: AppPaths.kPathFigures,
      page: FigureListPage,
    ),
    AutoRoute(
      path: '${AppPaths.kPathFigures}/${AppPaths.kViewCreate}',
      page: FigureCreatePage,
    ),
    RedirectRoute(
      path: '${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}',
      redirectTo:
          '${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewDetails}',
      page: FigureDetailsPage,
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathFigures}/:${AppPaths.kParamFigureId}/${AppPaths.kViewEdit}',
      page: FigureEditPage,
    ),

    /// Practices
    AutoRoute<List<PracticeViewModel>>(
      path: AppPaths.kPathPractices,
      page: PracticeListPage,
    ),
    AutoRoute(
      path: '${AppPaths.kPathPractices}/${AppPaths.kViewCreate}',
      page: PracticeCreatePage,
    ),
    RedirectRoute(
      path: '${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}',
      redirectTo:
          '${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewDetails}',
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewDetails}',
      page: PracticeDetailsPage,
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathPractices}/:${AppPaths.kParamPracticeId}/${AppPaths.kViewEdit}',
      page: PracticeEditPage,
    ),

    /// Videos
    AutoRoute<List<VideoViewModel>>(
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

    /// Moments
    AutoRoute(
      path: '${AppPaths.kPathMoments}/${AppPaths.kViewCreate}',
      page: MomentCreatePage,
    ),
    AutoRoute(
      path:
          '${AppPaths.kPathMoments}/:${AppPaths.kParamMomentId}/${AppPaths.kViewEdit}',
      page: MomentEditPage,
    ),
  ],
)
class AppRouter extends _$AppRouter {}
