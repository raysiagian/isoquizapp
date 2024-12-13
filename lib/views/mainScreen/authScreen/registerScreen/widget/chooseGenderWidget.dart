import 'package:flutter/material.dart';

class ChooseGenderWidget extends StatefulWidget {
  final String maleAvatar;
  final String femaleAvatar;
  final String? selectedOption;
  final Function(String) onOptionSelected;

  const ChooseGenderWidget({
    Key? key,
    required this.maleAvatar,
    required this.femaleAvatar,
    required this.selectedOption,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  State<ChooseGenderWidget> createState() => _ChooseAvatarWidgetState();
}

class _ChooseAvatarWidgetState extends State<ChooseGenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Opsi pria
        Expanded(
          child: _buildOption(widget.maleAvatar, 'Pria'),
        ),
        const SizedBox(width: 10), // Jarak antara opsi
        // Opsi wanita
        Expanded(
          child: _buildOption(widget.femaleAvatar, 'Wanita'),
        ),
      ],
    );
  }

  Widget _buildOption(String avatarPath, String label) {
    final isSelected = widget.selectedOption == label;

    return Material(
      color: Colors.transparent, // Pastikan InkWell bekerja
      child: InkWell(
        onTap: () {
          widget.onOptionSelected(label);
        },
        borderRadius: BorderRadius.circular(8.0), // Efek ripple berbentuk sesuai container
        child: Container(
          height: 150.0,
          width: 140.0,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar avatar
              Image.asset(
                avatarPath,
                height: 80, // Perbesar gambar
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              // Label avatar
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
