import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListView extends StatelessWidget {
  final Axis scrollDirection;

  const ArtistListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<ArtistListBloc, ArtistListState>(
      builder: (BuildContext context, ArtistListState state) {
        if (state is ArtistListUninitialized) {
          return ListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is ArtistListRefreshing) {
          return LoadingListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is ArtistListLoaded) {
          if (state.artists.isNotEmpty) {
            return _ArtistListViewLoaded(
              scrollDirection: scrollDirection,
            );
          } else {
            return ListView(
              scrollDirection: scrollDirection,
              children: [
                (scrollDirection == Axis.vertical)
                    ? const ListTile(title: Text('No Artists'))
                    : const Card(child: Text('No Artists'))
              ],
            );
          }
        }
        return ErrorListView(
          scrollDirection: scrollDirection,
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }
}

class _ArtistListViewLoaded extends StatefulWidget {
  final Axis scrollDirection;

  const _ArtistListViewLoaded({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _ArtistListViewLoadedState();
}

class _ArtistListViewLoadedState extends State<_ArtistListViewLoaded> {
  final _scrollController = ScrollController();

  _ArtistListViewLoadedState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistListBloc, ArtistListState>(
      builder: (context, state) {
        if (state is ArtistListLoaded) {
          return ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.artists.length
                : state.artists.length + 1,
            itemBuilder: (context, index) {
              if (widget.scrollDirection == Axis.vertical) {
                return (index < state.artists.length)
                    ? (widget.scrollDirection == Axis.vertical)
                        ? ArtistItemTile(artist: state.artists[index])
                        : ArtistItemCard(artist: state.artists[index])
                    : (widget.scrollDirection == Axis.vertical)
                        ? const BottomListLoadingIndicator()
                        : const RightListLoadingIndicator();
              }
              return ErrorListView(
                error: NotSupportedError(message: '${widget.scrollDirection}'),
              );
            },
          );
        }
        return ErrorListView(
          scrollDirection: widget.scrollDirection,
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }

  void _onScroll() {
    if (_isAtEnd) {
      context.read<ArtistListBloc>().add(const ArtistListLoadMore());
    }
  }

  bool get _isAtEnd {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
