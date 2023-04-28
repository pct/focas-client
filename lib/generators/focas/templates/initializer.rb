# frozen_string_literal: true

focas.configure do |config|
  # ========
  # 必要參數
  # ========

  # (0/1 使用財金資訊 正式站與否，預設為 0 測試站)
  config.production_mode = 0

  # **[必] 網站特店自訂代碼(請注意 merID 與 MerchantID 不同), number <= 10 (通常是統編)
  config.mer_id = ''

  # **[必] 收單銀行授權使用的特店代號(由收單銀行編製提供), number 固定 15
  config.merchant_id = '' 

  # **[必] 收單銀行授權使用的機台代號(由收單銀行編製提供), number 固定 8
  config.terminal_id = ''
  
  # 特店名稱，僅供顯示
  config.merchant_name = ''

  # **[必] 客製化付款授權網頁辨識碼(0: 預設不客製 / 1-8: 樣式1-8)
  config.customize = 1

  # ========
  # 其他參數
  # ========
  # 是否自動轉入請款檔作業 (0: 不自動轉入 / 1: 自動轉入)
  config.auto_cap = 1
  
  # 授權結果回傳網址，最多 512 位元組
  #config.callback_url = ''
  
  #  銀聯網路 UPOP 交易失敗，返回商戶跳轉網址
  #config.front_fail_url = ''
  
  # 交易類別碼 (0: 一般交易(預設) / 1: 分期交易 / 2: 紅利交易)
  #config.pay_type = 0
  
  # 分期期數 (1-99)
  #config.period_num = 1
  
  # 次特店代號，固定長度 8 位
  #config.sub_merch_id = '00000000'
  
  # *[必] 網頁編碼格式(預設為 BIG5)，所以必傳 "UTF-8"
  config.encode_type = 'UTF-8'
  
  # 設定交易逾時秒數，固定長度 3 位 (最大值為 600 秒)
  config.timeout_secs = 600
  
  # 交易幣別，固定長度 3 位 (901)
  config.currency = 901
  
  # 語言選擇，固定長度 1 位 (0: 繁 / 1: 簡 / 2: 英 / 3: 日)
  #config.lag_select = 0
  
  # 3D 交易驗證類型，若該特店設定支援 3D 交易，前端未帶此欄位，則預設為 0101 (0101 表示支付類交易驗證(PA)的 Payment transaction。 0204 表示非支付類交易驗證(NPA)的 Add card。0205 表示非支付類交易驗證(NPA)的 Maintain card。 
  #config.three_ds_auth_ind = '0101'
end
