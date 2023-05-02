# Focas::Client (開發中)

`focas-client` 是串接財金資訊 金流 API 的 rails gem。

目前狀態為`開發中`，請優先使用別的 focas 相關 gem 來達到您的需求(好像沒看到別的 gem...)

## NOTICE: 目前僅支援信用卡，不支援銀聯卡

## 測試用信用卡號
- 請跟財金公司索取

## 安裝
Gemfile：
```ruby
gem 'focas-client'
```

執行：
```bash
$ bundle install
```

建立 `config/initializers/focas.rb`：

```bash
$ rails generate focas:install
```

設定 `config/initializers/focas.rb`：

```yml
- config.production_mode        # 0: 開發環境 / 1: 正式站，預設為 0
- config.mer_id = ''            # 通常是統編
- config.marchant_id = ''       # 商店 ID
- config.terminal_id = ''       # 付費終端機 ID
- config.token = ''             # 驗證參數(token)，須在商店設定好
- config.customize = 1          # 使用客製頁面1
- config.auto_cap = 1           # 自動請款
- config.encode_type = 'UTF-8'  # 編碼一定要用 UTF-8，避免亂碼
- config.currency = 901         # 交易幣別，901 新台幣
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
