import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistListTile extends StatelessWidget {
  final ArtistViewModel artist;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const ArtistListTile({
    super.key,
    required this.artist,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(artist.name),
      leading: (artist.imageUrl != null)
          ? CircleAvatar(
              backgroundImage: NetworkImage(
                artist.imageUrl!,
              ),
              backgroundColor: Colors.transparent,
            )
          : null,
      onTap: onTap ??
          () {
            AutoRouter.of(context).push(
              ArtistDetailsRoute(artistId: artist.id),
            );
          },
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxArtistListTile extends StatelessWidget {
  final ArtistViewModel artist;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxArtistListTile({
    super.key,
    required this.artist,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(artist.name),
      value: value,
      onChanged: onChanged,
    );
  }
}

class ArtistCard extends StatelessWidget {
  final ArtistViewModel artist;

  const ArtistCard({
    super.key,
    required this.artist,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStyles.cardHeight,
      width: AppStyles.cardWidth,
      child: Card(
        elevation: AppStyles.cardElevation,
        child: GestureDetector(
          onTap: () {
            AutoRouter.of(context).push(
              ArtistDetailsRoute(artistId: artist.id),
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              _buildImage(),
              _buildGradient(),
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 5,
      bottom: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            artist.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() => (artist.imageUrl != null)
      ? Image.network(
          artist.imageUrl!,
          fit: BoxFit.cover,
        )
      : const SizedBox();
}

class ArtistForm extends StatelessWidget {
  const ArtistForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ArtistEditBloc artistEditBloc =
        BlocProvider.of<ArtistEditBloc>(context);
    return BlocBuilder<ArtistEditBloc, ArtistEditState>(
      builder: (BuildContext context, ArtistEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                initialValue: state.initialArtist?.name,
                onChanged: (artistName) {
                  artistEditBloc
                      .add(ArtistEditChangeName(artistName: artistName));
                },
              ),
              const SizedBox(
                height: AppStyles.formInputVerticalSpacing,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Image url',
                  hintText: 'http://image.com/myimage',
                ),
                initialValue: state.initialArtist?.imageUrl,
                onChanged: (artistImageUrl) {
                  artistEditBloc.add(
                      ArtistEditChangeImageUrl(artistImageUrl: artistImageUrl));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
