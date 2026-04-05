import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/asset.dart';
import 'providers/cash_provider.dart';

const _uuid = Uuid();

class CashFormPage extends ConsumerStatefulWidget {
  final String? editId;

  const CashFormPage({super.key, this.editId});

  @override
  ConsumerState<CashFormPage> createState() => _CashFormPageState();
}

class _CashFormPageState extends ConsumerState<CashFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _bankController = TextEditingController();
  final _amountController = TextEditingController();
  CurrencyCode _currency = CurrencyCode.twd;
  bool _isLoading = false;
  bool _isLoadingData = false;

  bool get isEditing => widget.editId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      _isLoadingData = true;
      _loadExisting();
    }
  }

  Future<void> _loadExisting() async {
    try {
      final repo = ref.read(cashRepositoryProvider);
      final asset = await repo.getById(widget.editId!);
      _nameController.text = asset.name;
      _bankController.text = asset.bankName;
      _amountController.text = asset.amount.toString();
      setState(() {
        _currency = asset.currency;
        _isLoadingData = false;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('載入失敗: $e')),
        );
        context.pop();
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bankController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final now = DateTime.now();
    final asset = CashAsset(
      id: widget.editId ?? _uuid.v4(),
      name: _nameController.text.trim(),
      createdAt: now,
      updatedAt: now,
      currency: _currency,
      bankName: _bankController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
    );

    try {
      final repo = ref.read(cashRepositoryProvider);
      if (isEditing) {
        await repo.update(asset);
      } else {
        await repo.insert(asset);
      }
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('儲存失敗: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? '編輯現金' : '新增現金'),
      ),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: '名稱',
                      hintText: '例：台幣活存',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '請輸入名稱' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _bankController,
                    decoration: const InputDecoration(
                      labelText: '銀行名稱',
                      hintText: '例：中國信託',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '請輸入銀行名稱' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<CurrencyCode>(
                    key: ValueKey(_currency),
                    initialValue: _currency,
                    decoration: const InputDecoration(labelText: '幣別'),
                    items: CurrencyCode.values
                        .map(
                          (c) => DropdownMenuItem(
                            value: c,
                            child: Text('${c.label}  ${c.symbol}'),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setState(() => _currency = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: '金額',
                      hintText: '例：100000',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '請輸入金額';
                      final n = double.tryParse(v.trim());
                      if (n == null || n < 0) return '請輸入有效金額';
                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  FilledButton(
                    onPressed: _isLoading ? null : _save,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(isEditing ? '更新' : '新增'),
                  ),
                ],
              ),
            ),
    );
  }
}
