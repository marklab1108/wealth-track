import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/asset.dart';
import '../../price/providers/price_provider.dart';
import 'providers/crypto_provider.dart';

const _uuid = Uuid();

class CryptoFormPage extends ConsumerStatefulWidget {
  final String? editId;

  const CryptoFormPage({super.key, this.editId});

  @override
  ConsumerState<CryptoFormPage> createState() => _CryptoFormPageState();
}

class _CryptoFormPageState extends ConsumerState<CryptoFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _symbolController = TextEditingController();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final _avgCostController = TextEditingController();
  final _symbolFocus = FocusNode();
  bool _isLoading = false;
  bool _isLoadingData = false;
  bool _isLookingUp = false;
  String _lastLookedUpSymbol = '';

  bool get isEditing => widget.editId != null;

  @override
  void initState() {
    super.initState();
    _symbolFocus.addListener(_onSymbolFocusChanged);
    if (isEditing) {
      _isLoadingData = true;
      _loadExisting();
    }
  }

  void _onSymbolFocusChanged() {
    if (!_symbolFocus.hasFocus) {
      _lookupSymbol();
    }
  }

  Future<void> _lookupSymbol() async {
    final symbol = _symbolController.text.trim().toUpperCase();
    if (symbol.isEmpty || symbol == _lastLookedUpSymbol) return;

    setState(() => _isLookingUp = true);
    _lastLookedUpSymbol = symbol;

    try {
      final coingecko = ref.read(coinGeckoServiceProvider);
      final quote = await coingecko.searchCoin(symbol);

      if (!mounted) return;

      if (quote != null) {
        _nameController.text = quote.name;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('找不到代號「$symbol」，請確認是否正確'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (_) {
      // Silently ignore lookup failures
    } finally {
      if (mounted) setState(() => _isLookingUp = false);
    }
  }

  Future<void> _loadExisting() async {
    try {
      final repo = ref.read(cryptoRepositoryProvider);
      final asset = await repo.getById(widget.editId!);
      _symbolController.text = asset.symbol;
      _nameController.text = asset.name;
      _amountController.text = asset.amount.toString();
      _avgCostController.text = asset.avgCost.toString();
      _lastLookedUpSymbol = asset.symbol;
      setState(() => _isLoadingData = false);
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
    _symbolFocus.removeListener(_onSymbolFocusChanged);
    _symbolFocus.dispose();
    _symbolController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _avgCostController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final symbol = _symbolController.text.trim().toUpperCase();
    final now = DateTime.now();
    final asset = CryptoAsset(
      id: widget.editId ?? _uuid.v4(),
      name: _nameController.text.trim().isEmpty
          ? symbol
          : _nameController.text.trim(),
      createdAt: now,
      updatedAt: now,
      symbol: symbol,
      amount: double.parse(_amountController.text.trim()),
      avgCost: double.parse(_avgCostController.text.trim()),
    );

    try {
      final repo = ref.read(cryptoRepositoryProvider);
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
      appBar: AppBar(title: Text(isEditing ? '編輯加密貨幣' : '新增加密貨幣')),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _symbolController,
                    focusNode: _symbolFocus,
                    decoration: const InputDecoration(
                      labelText: '代號',
                      hintText: '例：BTC',
                    ),
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '請輸入代號' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '名稱（選填，離開代號欄自動帶入）',
                      hintText: '例：Bitcoin',
                      suffixIcon: _isLookingUp
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2),
                              ),
                            )
                          : null,
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _amountController,
                    decoration: const InputDecoration(
                      labelText: '持有數量',
                      hintText: '例：0.5',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '請輸入數量';
                      final n = double.tryParse(v.trim());
                      if (n == null || n <= 0) return '請輸入有效數量';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _avgCostController,
                    decoration: const InputDecoration(
                      labelText: '平均成本 (USD)',
                      hintText: '例：45000',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '請輸入成本';
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
