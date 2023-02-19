import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class ArtistListWidgetParams implements ArtistListParams {
  final ArtistListBloc? artistListBloc;

  ArtistListWidgetParams(this.artistListBloc);
}

class ArtistListBlocProvider extends StatelessWidget implements ArtistListWidgetParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  /// Selection
  final List<ArtistViewModel>? preselectedArtists;

  /// Widget params
  final Widget child;

  const ArtistListBlocProvider({
    super.key,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,

    /// Selection
    this.preselectedArtists,

    /// Widget params
    required this.child,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDanceId == null && ofFigureId == null && ofVideoId == null));

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
            artistRepository: Provider.of<ArtistRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedArtists?.isNotEmpty ?? false) {
            artistListBloc.add(ArtistListSelect(artists: preselectedArtists!));
          }

          artistListBloc.add(ArtistListLoad(
            ofSearch: ofSearch,
            ofDanceId: ofDanceId,
            ofFigureId: ofFigureId,
            ofVideoId: ofVideoId,
          ));

          return artistListBloc;
        },
        child: child,
      );
    }
  }
}

class ArtistListView extends StatefulWidget implements ArtistListWidgetParams, EntityListViewParams {
  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

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
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDanceId == null && ofFigureId == null && ofVideoId == null));

  @override
  State<ArtistListView> createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: widget.artistListBloc,
      ofSearch: widget.ofSearch,
      ofDanceId: widget.ofDanceId,
      ofFigureId: widget.ofFigureId,
      ofVideoId: widget.ofVideoId,
      child: BlocListener<ArtistListBloc, ArtistListState>(
        listener: (context, ArtistListState state) {
          switch (state.status) {
            case ArtistListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.finishLoad();
              } else {
                _refreshController.finishLoad(IndicatorResult.noMore);
              }
              break;
            case ArtistListStatus.loadingFailure:
              _refreshController.finishLoad(IndicatorResult.fail);
              break;
            case ArtistListStatus.refreshingSuccess:
              _refreshController.finishRefresh(IndicatorResult.success);
              break;
            case ArtistListStatus.refreshingFailure:
              _refreshController.finishRefresh(IndicatorResult.fail);
              break;
            default:
          }
        },
        child: BlocBuilder<ArtistListBloc, ArtistListState>(
          builder: (BuildContext context, ArtistListState state) {
            final artistListBloc = BlocProvider.of<ArtistListBloc>(context);

            return EasyRefresh(
              controller: _refreshController,
              header: (widget.scrollDirection == Axis.horizontal) ? const MaterialHeader() : null,
              footer: (widget.scrollDirection == Axis.horizontal) ? const MaterialFooter() : null,
              onRefresh: () {
                artistListBloc.add(const ArtistListRefresh());
              },
              onLoad: () {
                artistListBloc.add(const ArtistListLoadMore());
              },
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.artists.length,
                itemBuilder: (context, index) {
                  final ArtistViewModel artist = state.artists[index];
                  final ArtistListBloc artistListBloc = BlocProvider.of<ArtistListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedArtists.isEmpty) {
                        return ArtistListTile(
                          ofArtist: artist,
                          onLongPress: (item) {
                            artistListBloc.add(
                              ArtistListSelect(artists: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxArtistListTile(
                          ofArtist: artist,
                          value: state.selectedArtists.any((element) => element.id == artist.id),
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
                      return ArtistCard(ofArtist: artist);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

class ArtistsSection extends StatelessWidget implements ArtistListWidgetParams, EntitiesSectionWidgetParams {
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
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  const ArtistsSection({
    super.key,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDanceId == null && ofFigureId == null && ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: artistListBloc,
      ofSearch: ofSearch,
      ofDanceId: ofDanceId,
      ofFigureId: ofFigureId,
      ofVideoId: ofVideoId,
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
                          artistListBloc: BlocProvider.of<ArtistListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.artistSectionHeight,
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
