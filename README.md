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
- config.production_mode # 0: 開發環境 / 1: 正式站，預設為 0
- config.marchant_id # 商店 ID
- config.hash_key
- config.hash_iv
```

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pct/focas-client.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
