# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'config'
require_relative 'errors'

module Focas
  class Payment
    attr_accessor :trade_info
    attr_reader :response

    def initialize(
      # 必填參數
      lidm: nil,
      purch_amt: nil,

      # 參數
      currency_note: '訂單金額說明',

      # 客製回傳網址(同一個站有不同接收的 route 時使用)
      auth_res_url: nil
    )
      unless lidm && purch_amt
        raise Focas::PaymentArgumentError,
          '請確認以下參數皆有填寫:
          - lidm 訂單編號
          - purch_amt 金額
        '
      end

      @lidm = lidm
      @purch_amt = purch_amt
      @currency_note = currency_note

      # 回傳網址
      @auth_res_url = auth_res_url

      set_trade_info
    end

    def success?
      return if @response.nil?
      @response['Status'] == 'SUCCESS'
    end

    def check_resp_token(data)
      # 資料錯誤的先 return
      return false if not data.present?

      ret = data.transform_keys(&:to_sym).to_h
      return false if not ret[:respToken].present?


      begin
        # to hash
        resp_token = ret[:respToken]

        options = Config.options
        settings = options.transform_keys(&:to_sym).to_h

        # 檢查 ret[:status] 成功或失敗
        if ret[:status] == '0'
          # 成功
          tmp_arr = %W(
          #{ret[:status]}
          #{ret[:lidm]}
          #{settings[:token]}
          #{ret[:authCode]}
          #{ret[:authRespTime]}
          #{settings[:merchant_id]}
          #{settings[:terminal_id]}
          )

          hash_string = tmp_arr.join('&')
        else
          # 失敗
          tmp_arr = %W(
          #{ret[:status]}
          #{ret[:errcode]}
          #{ret[:lidm]}
          #{settings[:token]}
          #{ret[:authRespTime]}
          #{settings[:merchant_id]}
          #{settings[:terminal_id]}
          )
        end

        # 開始驗證 token
        hash_token = Digest::SHA256.hexdigest(hash_string).upcase
        return (resp_token.upcase == hash_token)
      rescue
        return false
      end
    end

    private

    def set_trade_info
      options = Config.options
      @trade_info = options.transform_keys(&:to_sym).to_h
      local_date = Time.now.strftime('%Y%m%d')
      local_time = Time.now.strftime('%H%M%S')
      trade_time = "#{local_date}#{local_time}"

      # 訂單編號&交易金額&驗證參數&特店代號&端末代號&交易時間
      hash_string = "#{@lidm}#{@purch_amt}#{@trade_info[:token]}#{@trade_info[:merchant_id]}#{@trade_info[:terminal_id]}#{trade_time}"

      req_token = Digest::SHA256.hexdigest(hash_string).upcase

      individual_trade_info = {
        lidm: @lidm, # 商店訂單編號，如：用途_日期時間戳記_流水號
        purchAmt: @purch_amt.to_i, # 訂單金額
        CurrencyNote: @currency_note, # 商品資訊
        # 回傳網址
        AuthResURL: @auth_res_url,
        reqToken: req_token,
        LocalDate: local_date,
        LocalTime: local_time
      }

      individual_trade_info.merge!(options[:trade_info]) if options[:trade_info]

      # 同是 hash 再來 merge
      @trade_info = (options.to_h.merge!(individual_trade_info)).transform_keys(&:to_sym)
    end
  end
end
