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

    private

    def set_trade_info
      options = Config.options
      @trade_info = options.transform_keys(&:to_sym).to_h

      individual_trade_info = {
        lidm: @lidm, # 商店訂單編號，如：用途_日期時間戳記_流水號
        purchAmt: @purch_amt.to_i, # 訂單金額
        CurrencyNote: @currency_note, # 商品資訊
        # 回傳網址
        AuthResURL: @auth_res_url,
      }

      individual_trade_info.merge!(options[:trade_info]) if options[:trade_info]

      # 同是 hash 再來 merge
      @trade_info = (options.to_h.merge!(individual_trade_info)).transform_keys(&:to_sym)
    end
  end
end
