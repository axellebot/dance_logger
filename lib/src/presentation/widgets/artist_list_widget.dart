import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListView extends StatefulWidget {
  final Axis scrollDirection;

  const ArtistListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<StatefulWidget> createState() => _ArtistListViewState();
}

class _ArtistListViewState extends State<ArtistListView> {
  final _scrollController = ScrollController();

  _ArtistListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<ArtistListBloc, ArtistListState>(
      builder: (BuildContext context, ArtistListState state) {
        switch (state.status) {
          case ArtistListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
            );
          case ArtistListStatus.failure:
          case ArtistListStatus.success:
            if (state.artists.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                label: 'No Artists',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.artists.length
                    : state.artists.length + 1,
                itemBuilder: (context, index) {
                  return (index < state.artists.length)
                      ? (widget.scrollDirection == Axis.vertical)
                          ? ArtistItemTile(artist: state.artists[index])
                          : ArtistItemCard(artist: state.artists[index])
                      : (widget.scrollDirection == Axis.vertical)
                          ? const BottomListLoadingIndicator()
                          : const RightListLoadingIndicator();
                },
              );
            }
          default:
            return ErrorListView(
              scrollDirection: widget.scrollDirection,
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<ArtistListBloc>().add(const ArtistListLoadMore());
    }
  }

  bool get _shouldLoadMore {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final scrollThreshold = (maxScroll * 0.9);
    final currentScroll = _scrollController.offset;
    return currentScroll >= scrollThreshold;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
