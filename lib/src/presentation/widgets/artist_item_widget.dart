import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class ArtistItemTile extends StatelessWidget {
  final ArtistViewModel artist;

  const ArtistItemTile({
    super.key,
    required this.artist,
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
      onTap: () {
        AutoRouter.of(context).push(
          ArtistDetailsRoute(artistId: artist.id),
        );
      },
    );
  }
}

class ArtistItemCard extends StatelessWidget {
  final ArtistViewModel artist;

  const ArtistItemCard({
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
          onTap: () => AutoRouter.of(context).push(
            ArtistDetailsRoute(artistId: artist.id),
          ),
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

class ArtistForm extends StatefulWidget {
  const ArtistForm({super.key});

  @override
  State<StatefulWidget> createState() => _ArtistFormState();
}

class _ArtistFormState extends State<ArtistForm> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(controller: nameController),
        ],
      ),
    );
  }
}
