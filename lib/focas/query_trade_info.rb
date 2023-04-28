# frozen_string_literal: true

require 'net/http'
require 'json'

require_relative 'config'
require_relative 'errors'

module Focas
  class QueryTradeInfo
    attr_accessor :trade_info
    attr_reader :response

    def initialize(
      lidm: nil,
      purch_amt: nil,
      res_url: nil
    )
      unless lidm && purch_amt
        raise Focas::PaymentArgumentError,
          '請確認以下參數皆有填寫:
          - lidm
          - purch_amt
          '
      end

      @lidm = lidm
      @purch_amt = purch_amt
      @res_url = res_url
      @xid = xid

      set_trade_info
      set_check_value
    end

    def request!
      uri = URI("#{Config.api_base_url}/FOCAS_WEBPOS/orderInquery/")

      res = Net::HTTP.post_form(uri,
        merID: Config.options[:merID], 
        MerchantID: Config.options[:MerchantID],
        TerminalID: Config.options[:TerminalID],
        lidm: @lidm,
        purchAmt: @purch_amt,
        ResURL: @res_url,
        xid: @xid
      )

      @response = JSON.parse(res.body)
    end

    def success?
      return if @response.nil?

      @response['Status'] == 'SUCCESS'
    end

    private

  end
end
