// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

class LineBusyScreen extends StatefulWidget {
  /// 'طوارئ' or 'إسعاف' — determines the title shown
  final String callType;

  const LineBusyScreen({super.key, required this.callType});

  @override
  _LineBusyScreenState createState() => _LineBusyScreenState();
}

class _LineBusyScreenState extends State<LineBusyScreen> {
  bool _isRetrying = false;

  Future<void> _retry() async {
    setState(() => _isRetrying = true);

    // Simulate calling delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() => _isRetrying = false);
      // For demo: always comes back as busy
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warning,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),

              //  Calling type label
              Text(
                'الاتصال بـ ${widget.callType}',
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 16,
                  color: AppColors.textMedium,
                ),
              ),

              const SizedBox(height: 28),

              // Crossed phone icon
              _CrossedPhoneIcon(isRetrying: _isRetrying),

              const SizedBox(height: 36),

              //  Status text
              Text(
                _isRetrying ? AppStrings.calling : AppStrings.lineBusy,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              //  Action buttons
              Row(
                children: [
                  // Close button (red)
                  Expanded(
                    child: _ActionButton(
                      label: AppStrings.close,
                      icon: Icons.call_end,
                      color: AppColors.error,
                      onPressed: _isRetrying
                          ? null
                          : () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Retry button (green)
                  Expanded(
                    child: _ActionButton(
                      label: AppStrings.retry,
                      icon: Icons.refresh,
                      color: AppColors.success,
                      onPressed: _isRetrying ? null : _retry,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _CrossedPhoneIcon extends StatelessWidget {
  final bool isRetrying;
  const _CrossedPhoneIcon({required this.isRetrying});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        border: Border.all(color: AppColors.textDark, width: 2.5),
        color: AppColors.warning,
      ),
      child: Center(
        child: Icon(
          isRetrying ? Icons.phone_in_talk : Icons.phone_disabled,
          color: isRetrying ? AppColors.success : AppColors.error,
          size: 70,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: onPressed == null ? AppColors.textLight : color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 8),
            // Icon inside small box (matches original design)
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: AppColors.white, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}
