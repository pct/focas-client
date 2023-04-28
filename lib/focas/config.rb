# frozen_string_literal: true

require 'securerandom'

# for mattr_accessor
require 'active_support/core_ext/module/attribute_accessors'

# for with_indifferent_access
require 'active_support/core_ext/hash/indifferent_access'

module Focas

  module Config
    mattr_accessor :options
    mattr_accessor :production_mode # 0/1，預設為 0，使用開發環境網址
    mattr_accessor :api_base_url # 依據 production_mode 設定 api 網址

    OPTIONS = %w[
      merID
      MerchantID
      TerminalID
      MerchantName
      customize
      lidm
      purchAmt
      CurrencyNote
      AutoCap
      AuthResURL
      frontFailUrl
      PayType
      PeriodNum
      LocalDate
      LocalTime
      reqToken
      subMerchID
      enCodeType
      timeoutDate
      timeoutTime
      timeoutSecs
      Currency
      lagSelect
      threeDSAuthInd
    ].freeze

    # 標 **[必] 為必填，另外 threeDSAuthInd 是 3DS 驗證，需要時就必填 
    # TradeInfo 參數
    MAPPING_TABLE = {
      merID: 'mer_id', # **[必] 網站特店自訂代碼(請注意 merID 與 MerchantID 不同), number <= 10
      MerchantID: 'merchant_id', # **[必] 收單銀行授權使用的特店代號(由收單銀行編製提供), number 固定 15
      TerminalID: 'terminal_id', # **[必] 收單銀行授權使用的機台代號(由收單銀行編製提供), number 固定 8
      MerchantName: 'merchant_name', # 特店名稱，僅供顯示
      customize: 'customize', # **[必] 客製化付款授權網頁辨識碼(0: 不客製；1-8 有 8 種客製化樣式可選擇)
      lidm: 'lidm', # * 交易訂單編號，建議訂單編號不可重複編號，且在 16 位以下最佳(如果是銀聯卡，則不能用 -、_ 符號)
      purchAmt: 'purch_amt', # **[必] 新台幣整數(10 位數內)，如果是金融卡，最大交易為 200 萬
      CurrencyNote: 'currency_note', # 註記說明，50 字內
      AutoCap: 'auto_cap', # 是否自動轉入請款檔作業 (0: 預設不轉入 / 1: 自動轉入)
      AuthResURL: 'auth_res_url', # 授權結果回傳網址，最多 512 位元組
      frontFailUrl: 'front_fail_url', #  銀聯網路 UPOP 交易失敗，返回商戶跳轉網址
      PayType: 'pay_type', # 交易類別碼 (0: 預設一般交易 / 1: 分期 / 2: 紅利)
      PeriodNum: 'period_num', # 分期期數 (1-99)
      LocalDate: 'local_date', # 購買地交易日期(yyyymmdd)(預設為系統日期)
      LocalTime: 'local_time', # 購買地交易時間(HHMMSS) (預設為系統時間)
      reqToken: 'req_token', # 交易驗證碼，最大長度 64 位
      subMerchID: 'sub_merch_id', # 次特店代號，固定長度 8 位
      enCodeType: 'encode_type', # *[必] 網頁編碼格式(預設為 BIG5)，所以必傳 "UTF-8"
      timeoutDate: 'timeout_date', # 設定交易逾時日期(yyyymmdd)，固定長度 8 位
      timeoutTime: 'timeout_time', # 設定交易逾時起始時間(HHMMSS)，固定長度 6 位
      timeoutSecs: 'timeout_secs', # 設定交易逾時秒數，固定長度 3 位 (最大值為 600 秒)
      Currency: 'currency', # 交易幣別，固定長度 3 位 (901)
      lagSelect: 'lag_select', # 語言選擇，固定長度 1 位 (0: 繁 / 1: 簡 / 2: 英 / 3: 日 )
      threeDSAuthInd: 'three_ds_auth_ind', # 3D 交易驗證類型，若該特店設定支援 3D 交易，前端未帶此欄位，則預設為 0101 (0101 表示支付類交易驗證(PA)的 Payment transaction。 0204 表示非支付類交易驗證(NPA)的 Add card。0205 表示非支付類交易驗證(NPA)的 Maintain card。 註:綁卡驗證應使用 0204 或 0205)
    }.freeze

    self.options = {}.with_indifferent_access

    OPTIONS.each do |option|
      transfer_option = MAPPING_TABLE[:"#{option}"]
      define_method("#{transfer_option}=") do |value|
        options[option] = value
      end
    end

    def configure
      yield self
    end

    def api_base_url
      self.production_mode ||= 0
      self.api_base_url = self.production_mode == 0 ? 
        'https://www.focas-test.fisc.com.tw' : 
        'https://www.focas.fisc.com.tw'
    end

    def get_payment_url
      "#{self.api_base_url}/FOCAS_WEBPOS/online/"
    end

    def create_lidm
      lidm = "#{Time.now.strftime("%Y%m%d%H%M%S")}_#{SecureRandom.hex(2).upcase}"
    end
  end
end
