RSpec.describe 'Focas::Payment 付款' do
  describe '* 檢查付款表單裡面的值' do
    lidm = Focas.create_lidm

    params = Focas::Payment.new(
      lidm: lidm,
      purch_amt: 100
    ).trade_info

    puts params

    it '* 測試商店 merID 有正確代入' do
      expect(params[:merID]).to eq Focas.options[:merID]
    end

    it '* 測試商店 MerchantID 有正確代入' do
      expect(params[:MerchantID]).to eq Focas.options[:MerchantID]
    end

    it '* 測試商店 TerminalID 有正確代入' do
      expect(params[:TerminalID]).to eq Focas.options[:TerminalID]
    end
  end

  ### 測試發起財金資訊 訂單「頁面」，尚未能 post
  #it "* 可發起刷卡功能，在財金資訊 產生訂單" do
  #  lidm = Focas.create_lidm

  #  trade_info = Focas::Payment.new(
  #    lidm: lidm,
  #    purch_amt: 100
  #  )

  #  res = trade_info.request!
  #  puts res
  #end
end
