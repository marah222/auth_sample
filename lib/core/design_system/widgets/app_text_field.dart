import 'package:auth_sample/core/constants/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../app_colors.dart';
import '../app_spacing.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final dynamic prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isClearText;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.isClearText=false,
    this.isPassword = false,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController _controller;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _obscureText = widget.isPassword;
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _clearText() {
    setState(() => _controller.clear());
    widget.onChanged?.call('');
  }

  void _togglePasswordVisibility() {
    setState(() => _obscureText = !_obscureText);
  }


  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;

    if (widget.prefixIcon is IconData) {
      return Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: Icon(widget.prefixIcon, color: AppColors.primaryDarkText),
      );
    } else if (widget.prefixIcon is String) {
      return Padding(
        padding: const EdgeInsets.only(left: 4, right: 8),
        child: SvgPicture.asset(
          widget.prefixIcon,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(AppColors.primaryDarkText, BlendMode.srcIn),
        ),
      );
    }
    return null;
  }

  Widget? _buildSuffixIcon() {
    // If a custom widget is passed, use it directly.
    if (widget.suffixIcon != null) return  widget.suffixIcon;

    // If password field → toggle visibility icon.
    if (widget.isPassword) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility: Icons.visibility_off,
          color: AppColors.secondaryText,
        ),
        onPressed: _togglePasswordVisibility,
      );
    }

    if (widget.isClearText && _controller.text.isNotEmpty) {
      return IconButton(
        icon: SvgPicture.asset(AppIcons.xCircle, color: AppColors.secondaryText),
        onPressed: _clearText,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryDarkText,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _controller,
          obscureText: _obscureText,
          onChanged: (value) {
            setState(() {});
            widget.onChanged?.call(value);
          },
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.primaryDarkText,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: textTheme.bodyLarge?.copyWith(
              color: AppColors.secondaryText,
            ),
            prefixIcon: _buildPrefixIcon(),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: _buildSuffixIcon(),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
            filled: false,
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.8),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 0.8),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
