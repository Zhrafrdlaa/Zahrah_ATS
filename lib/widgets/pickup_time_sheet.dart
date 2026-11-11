import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_text_styles.dart';
import '../core/formatters.dart';
import '../data/dummy_data.dart';
import '../viewmodels/cart_viewmodel.dart';
import 'app_button.dart';
import 'app_snackbar.dart';

/// Modal "Pilih Waktu Ambil".
class PickupTimeSheet extends StatefulWidget {
  const PickupTimeSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => const PickupTimeSheet(),
    );
  }

  @override
  State<PickupTimeSheet> createState() => _PickupTimeSheetState();
}

class _PickupTimeSheetState extends State<PickupTimeSheet> {
  int _selectedMinutes = DummyData.pickupMinutes.first;
  DateTime? _customTime;

  String _labelFor(int minutes) =>
      minutes == 15 ? 'Secepatnya' : (minutes == 60 ? '1 jam lagi' : '$minutes menit lagi');

  Future<void> _pickCustomTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now().add(const Duration(hours: 1))),
    );
    if (picked == null || !mounted) return;

    final now = DateTime.now();
    final candidate = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    if (candidate.isBefore(now.add(const Duration(minutes: 10)))) {
      AppSnackBar.show(context, 'Pilih jam minimal 10 menit dari sekarang.', isError: true);
      return;
    }
    setState(() => _customTime = candidate);
  }

  void _save() {
    final cart = context.read<CartViewModel>();
    if (_customTime != null) {
      cart.setPickupAt(_customTime!);
    } else {
      cart.setPickupAfter(_selectedMinutes);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                    color: AppColors.surface, borderRadius: BorderRadius.circular(4)),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Text('Pilih Waktu Ambil', style: AppTextStyles.title)),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text('Pilih kapan pesanan kopimu ingin diambil di gerai',
                style: AppTextStyles.caption),
            const SizedBox(height: 12),
            ...DummyData.pickupMinutes.map((minutes) {
              final isSelected = _customTime == null && _selectedMinutes == minutes;
              return _OptionRow(
                label: _labelFor(minutes),
                trailing: Formatters.time(now.add(Duration(minutes: minutes))),
                selected: isSelected,
                onTap: () => setState(() {
                  _selectedMinutes = minutes;
                  _customTime = null;
                }),
              );
            }),
            _OptionRow(
              label: 'Pilih jam sendiri',
              trailing: _customTime == null ? '' : Formatters.time(_customTime!),
              selected: _customTime != null,
              onTap: _pickCustomTime,
            ),
            const SizedBox(height: 16),
            AppButton(label: 'Simpan Waktu Ambil', icon: Icons.check_circle_outline, onPressed: _save),
          ],
        ),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
    required this.label,
    required this.trailing,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final String trailing;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withValues(alpha: 0.12) : AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: selected ? AppColors.primary : Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off,
                size: 20, color: selected ? AppColors.primary : AppColors.textMuted),
            const SizedBox(width: 12),
            Expanded(child: Text(label, style: AppTextStyles.bodyDark)),
            Text(trailing, style: AppTextStyles.caption),
          ],
        ),
      ),
    );
  }
}
