import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/asset.dart';
import '../../price/providers/price_provider.dart';
import 'providers/stock_provider.dart';

const _uuid = Uuid();

class StockFormPage extends ConsumerStatefulWidget {
  final String? editId;
  final StockMarket market;

  const StockFormPage({
    super.key,
    this.editId,
    this.market = StockMarket.us,
  });

  @override
  ConsumerState<StockFormPage> createState() => _StockFormPageState();
}

class _StockFormPageState extends ConsumerState<StockFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _symbolController = TextEditingController();
  final _nameController = TextEditingController();
  final _sharesController = TextEditingController();
  final _avgCostController = TextEditingController();
  final _symbolFocus = FocusNode();
  bool _isLoading = false;
  bool _isLoadingData = false;
  bool _isLookingUp = false;
  String _lastLookedUpSymbol = '';

  bool get isEditing => widget.editId != null;
  bool get _isTw => widget.market == StockMarket.tw;

  String get _appBarTitle {
    final action = isEditing ? '編輯' : '新增';
    return _isTw ? '$action台股' : '$action美股';
  }

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
      String? resolvedName;

      if (_isTw) {
        // MIS API: covers 上市、上櫃、ETF — returns Chinese name
        final mis = ref.read(twseMisServiceProvider);
        final quote = await mis.getQuote(symbol);
        resolvedName = quote?.name;

        // Fallback: TWSE company list (上市 only)
        if (resolvedName == null) {
          final twse = ref.read(twseServiceProvider);
          resolvedName = await twse.getChineseName(symbol);
        }
      }

      if (resolvedName == null) {
        final yahoo = ref.read(yahooFinanceServiceProvider);
        final yahooSym = toYahooSymbol(symbol, widget.market);
        final quote = await yahoo.getQuote(yahooSym);
        resolvedName = quote?.shortName;

        if (quote == null && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('找不到代號「$symbol」，請確認是否正確'),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      }

      if (!mounted) return;

      if (resolvedName != null) {
        _nameController.text = resolvedName;
      }
    } catch (_) {
      // Silently ignore lookup failures
    } finally {
      if (mounted) setState(() => _isLookingUp = false);
    }
  }

  Future<void> _loadExisting() async {
    try {
      final repo = ref.read(stockRepositoryProvider);
      final asset = await repo.getById(widget.editId!);
      _symbolController.text = asset.symbol;
      _nameController.text = asset.name;
      _sharesController.text = asset.shares.toString();
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
    _sharesController.dispose();
    _avgCostController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final symbol = _symbolController.text.trim().toUpperCase();
    final now = DateTime.now();
    final asset = StockAsset(
      id: widget.editId ?? _uuid.v4(),
      name: _nameController.text.trim().isEmpty
          ? symbol
          : _nameController.text.trim(),
      createdAt: now,
      updatedAt: now,
      symbol: symbol,
      market: widget.market,
      shares: double.parse(_sharesController.text.trim()),
      avgCost: double.parse(_avgCostController.text.trim()),
    );

    try {
      final repo = ref.read(stockRepositoryProvider);
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
    final symbolHint = _isTw ? '例：2330' : '例：AAPL';
    final nameHint = _isTw ? '例：台積電' : '例：Apple Inc.';
    final costLabel = _isTw ? '平均成本 (TWD)' : '平均成本 (USD)';
    final costHint = _isTw ? '例：850' : '例：150.00';

    return Scaffold(
      appBar: AppBar(title: Text(_appBarTitle)),
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
                    decoration: InputDecoration(
                      labelText: '股票代號',
                      hintText: symbolHint,
                    ),
                    textCapitalization: _isTw
                        ? TextCapitalization.none
                        : TextCapitalization.characters,
                    keyboardType: _isTw ? TextInputType.number : null,
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '請輸入股票代號' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '名稱（選填，離開代號欄自動帶入）',
                      hintText: nameHint,
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
                    controller: _sharesController,
                    decoration: InputDecoration(
                      labelText: '持有股數',
                      hintText: _isTw ? '例：1000' : '支援碎股，例：10.5',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '請輸入股數';
                      final n = double.tryParse(v.trim());
                      if (n == null || n <= 0) return '請輸入有效股數';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _avgCostController,
                    decoration: InputDecoration(
                      labelText: costLabel,
                      hintText: costHint,
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
