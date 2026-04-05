import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/models/asset.dart';
import '../../price/providers/price_provider.dart';
import 'providers/fund_provider.dart';

const _uuid = Uuid();

class FundFormPage extends ConsumerStatefulWidget {
  final String? editId;

  const FundFormPage({super.key, this.editId});

  @override
  ConsumerState<FundFormPage> createState() => _FundFormPageState();
}

class _FundFormPageState extends ConsumerState<FundFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _unitsController = TextEditingController();
  final _avgCostController = TextEditingController();
  final _codeFocus = FocusNode();
  bool _isLoading = false;
  bool _isLoadingData = false;
  bool _isLookingUp = false;
  String _lastLookedUpCode = '';

  bool get isEditing => widget.editId != null;

  @override
  void initState() {
    super.initState();
    _codeFocus.addListener(_onCodeFocusChanged);
    if (isEditing) {
      _isLoadingData = true;
      _loadExisting();
    }
  }

  void _onCodeFocusChanged() {
    if (!_codeFocus.hasFocus) {
      _lookupFund();
    }
  }

  Future<void> _lookupFund() async {
    final code = _codeController.text.trim();
    if (code.isEmpty || code == _lastLookedUpCode) return;

    setState(() => _isLookingUp = true);
    _lastLookedUpCode = code;

    try {
      final svc = ref.read(yahooFundServiceProvider);
      final quote = await svc.getQuote(code);

      if (!mounted) return;

      if (quote != null) {
        _nameController.text = quote.name;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('找不到此基金代號，請確認是否正確\n'
                '代號可從 Yahoo 股市基金頁面 URL 取得'),
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('查詢失敗，請檢查網路連線')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLookingUp = false);
    }
  }

  Future<void> _loadExisting() async {
    try {
      final repo = ref.read(fundRepositoryProvider);
      final asset = await repo.getById(widget.editId!);
      _codeController.text = asset.fundCode;
      _nameController.text = asset.name;
      _unitsController.text = asset.units.toString();
      _avgCostController.text = asset.avgCost.toString();
      _lastLookedUpCode = asset.fundCode;
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
    _codeFocus.removeListener(_onCodeFocusChanged);
    _codeFocus.dispose();
    _codeController.dispose();
    _nameController.dispose();
    _unitsController.dispose();
    _avgCostController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    final now = DateTime.now();
    final asset = FundAsset(
      id: widget.editId ?? _uuid.v4(),
      name: _nameController.text.trim().isEmpty
          ? _codeController.text.trim()
          : _nameController.text.trim(),
      createdAt: now,
      updatedAt: now,
      fundCode: _codeController.text.trim(),
      units: double.parse(_unitsController.text.trim()),
      avgCost: double.parse(_avgCostController.text.trim()),
      currentNav: null,
      navUpdatedAt: null,
    );

    try {
      final repo = ref.read(fundRepositoryProvider);
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
      appBar: AppBar(title: Text(isEditing ? '編輯基金' : '新增基金')),
      body: _isLoadingData
          ? const Center(child: CircularProgressIndicator())
          : Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    controller: _codeController,
                    focusNode: _codeFocus,
                    decoration: const InputDecoration(
                      labelText: 'Yahoo 基金代號',
                      hintText: '例：F000014SAX:FO',
                      helperText: '從 Yahoo 股市基金頁面 URL 取得',
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? '請輸入基金代號' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: '基金名稱（離開代號欄自動帶入）',
                      hintText: '例：元大台灣50',
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
                    controller: _unitsController,
                    decoration: const InputDecoration(
                      labelText: '持有單位數',
                      hintText: '例：1000',
                    ),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d*$'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) return '請輸入單位數';
                      final n = double.tryParse(v.trim());
                      if (n == null || n <= 0) return '請輸入有效數量';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _avgCostController,
                    decoration: const InputDecoration(
                      labelText: '平均成本 (TWD)',
                      hintText: '例：35.50',
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
