import 'package:flutter/material.dart';

enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  destructive,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final Widget? icon;
  final bool isLoading;
  final bool isDisabled;
  final double? width;
  final EdgeInsets? padding;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // 获取按钮样式配置
    final buttonConfig = _getButtonConfig(colorScheme);
    
    return SizedBox(
      width: width,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: (isDisabled || isLoading) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonConfig.backgroundColor,
          foregroundColor: buttonConfig.foregroundColor,
          side: buttonConfig.borderSide,
          elevation: buttonConfig.elevation,
          shadowColor: buttonConfig.shadowColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: padding ?? _getButtonPadding(),
        ),
        child: _buildButtonContent(),
      ),
    );
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getButtonConfig(Theme.of(context as BuildContext).colorScheme).foregroundColor,
          ),
        ),
      );
    }

    final List<Widget> children = [];
    
    if (icon != null) {
      children.add(
        SizedBox(
          width: _getIconSize(),
          height: _getIconSize(),
          child: icon,
        ),
      );
      children.add(const SizedBox(width: 8));
    }
    
    children.add(
      Text(
        text,
        style: TextStyle(
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  ButtonConfig _getButtonConfig(ColorScheme colorScheme) {
    switch (variant) {
      case ButtonVariant.primary:
        return ButtonConfig(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 2,
        );
      case ButtonVariant.secondary:
        return ButtonConfig(
          backgroundColor: colorScheme.secondary,
          foregroundColor: colorScheme.onSecondary,
          elevation: 1,
        );
      case ButtonVariant.outline:
        return ButtonConfig(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          borderSide: BorderSide(color: colorScheme.primary, width: 1),
          elevation: 0,
        );
      case ButtonVariant.ghost:
        return ButtonConfig(
          backgroundColor: Colors.transparent,
          foregroundColor: colorScheme.primary,
          elevation: 0,
        );
      case ButtonVariant.destructive:
        return ButtonConfig(
          backgroundColor: colorScheme.error,
          foregroundColor: colorScheme.onError,
          elevation: 2,
        );
    }
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 40;
      case ButtonSize.large:
        return 48;
    }
  }

  EdgeInsets _getButtonPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 12);
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 18;
      case ButtonSize.large:
        return 20;
    }
  }
}

class ButtonConfig {
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderSide? borderSide;
  final double elevation;
  final Color? shadowColor;

  const ButtonConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderSide,
    this.elevation = 0,
    this.shadowColor,
  });
}