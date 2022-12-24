import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class ArtistListWidgetParams implements ArtistListParams {
  /// ListBloc params
  final ArtistListBloc? artistListBloc;

  ArtistListWidgetParams(this.artistListBloc);
}

class ArtistListBlocProvider extends StatelessWidget
    implements ArtistListWidgetParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Selection
  final List<ArtistViewModel>? preselectedArtists;

  /// Widget params
  final Widget child;

  const ArtistListBlocProvider({
    super.key,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// Selection
    this.preselectedArtists,

    /// Widget params
    required this.child,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    if (artistListBloc != null) {
      return BlocProvider<ArtistListBloc>.value(
        value: artistListBloc!,
        child: child,
      );
    } else {
      return BlocProvider(
        create: (context) {
          final artistListBloc = ArtistListBloc(
            artistRepository:
                Provider.of<ArtistRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedArtists?.isNotEmpty ?? false) {
            artistListBloc.add(ArtistListSelect(artists: preselectedArtists!));
          }

          artistListBloc.add(ArtistListLoad(
            ofSearch: ofSearch,
            ofDance: ofDance,
            ofFigure: ofFigure,
            ofVideo: ofVideo,
          ));

          return artistListBloc;
        },
        child: child,
      );
    }
  }
}

class ArtistListView extends StatefulWidget
    implements ArtistListWidgetParams, EntityListViewParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  const ArtistListView({
    super.key,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  State<ArtistListView> createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: widget.artistListBloc,
      ofSearch: widget.ofSearch,
      ofDance: widget.ofDance,
      ofFigure: widget.ofFigure,
      ofVideo: widget.ofVideo,
      child: BlocListener<ArtistListBloc, ArtistListState>(
        listener: (context, ArtistListState state) {
          switch (state.status) {
            case ArtistListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
              break;
            case ArtistListStatus.loadingFailure:
              _refreshController.loadFailed();
              break;
            case ArtistListStatus.refreshingSuccess:
              _refreshController.refreshCompleted(resetFooterState: true);
              break;
            case ArtistListStatus.refreshingFailure:
              _refreshController.refreshFailed();
              break;
            default:
          }
        },
        child: BlocBuilder<ArtistListBloc, ArtistListState>(
          builder: (BuildContext context, ArtistListState state) {
            final artistListBloc = BlocProvider.of<ArtistListBloc>(context);

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () {
                artistListBloc.add(const ArtistListRefresh());
              },
              onLoading: () {
                artistListBloc.add(const ArtistListLoadMore());
              },
              scrollDirection: widget.scrollDirection,
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.artists.length,
                itemBuilder: (context, index) {
                  final ArtistViewModel artist = state.artists[index];
                  final ArtistListBloc artistListBloc =
                      BlocProvider.of<ArtistListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedArtists.isEmpty) {
                        return ArtistListTile(
                          artist: artist,
                          onLongPress: (item) {
                            artistListBloc.add(
                              ArtistListSelect(artists: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxArtistListTile(
                          artist: artist,
                          value: state.selectedArtists
                              .any((element) => element.id == artist.id),
                          onChanged: (bool? value) {
                            artistListBloc.add(
                              (value == true)
                                  ? ArtistListSelect(artists: [artist])
                                  : ArtistListUnselect(artists: [artist]),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return ArtistAvatar(artist: artist);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class ArtistsSection extends StatelessWidget
    implements ArtistListWidgetParams, EntitiesSectionWidgetParams {
  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const ArtistsSection({
    super.key,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: artistListBloc,
      ofSearch: ofSearch,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                leading: const Icon(Icons.people),
                title: Text(label ?? 'Artists'),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        ArtistListRoute(
                          artistListBloc:
                              BlocProvider.of<ArtistListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: ArtistListView(
                  artistListBloc: BlocProvider.of<ArtistListBloc>(context),
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
