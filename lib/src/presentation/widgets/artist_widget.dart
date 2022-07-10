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
      onTap: () => AutoRouter.of(context).push(
        ArtistDetailsRoute(artistId: artist.id),
      ),
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
      child: GestureDetector(
        onTap: () => AutoRouter.of(context).push(
          ArtistDetailsRoute(artistId: artist.id),
        ),
        child: Card(
          elevation: AppStyles.cardElevation,
          child: Container(
            padding: AppStyles.cardPadding,
            child: Text(artist.name),
          ),
        ),
      ),
    );
  }
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
