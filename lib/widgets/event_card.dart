import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const EventCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    String? id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      constraints: const BoxConstraints(maxWidth: 400.0),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Stack(
        children: [
          // Imagem de fundo
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: SizedBox(
              height: 250.0,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/img/letsTicketWhiteLogo.png', // Imagem padrão em caso de erro
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          // Overlay com o título
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 45.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
