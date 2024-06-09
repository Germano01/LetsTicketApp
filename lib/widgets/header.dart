import 'package:flutter/material.dart';
import 'package:trab/themes/colors.dart';

class CustomHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onSupportPressed;

  const CustomHeader({
    Key? key,
    required this.userName,
    required this.onSupportPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor, // Define o fundo como azul
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/img/letsTicketWhiteLogo.png',
                height: 42.0,
              ),
              const CircleAvatar(
                backgroundColor: AppColors.whiteColor,
                child: Icon(Icons.person, size: 36.0, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Bem vindo, ',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: userName,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24.0),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Pesquisar...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.0),
                child: IconButton(
                  icon: const Icon(Icons.filter_list,
                      size: 30.0, color: AppColors.whiteColor),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
