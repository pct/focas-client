RSpec.describe 'Focas::Config 設定' do
  it '* 開發/正式站 API URL' do
    if Focas.production_mode == 0
      # 測試站
      expect(Focas.api_base_url).to eq 'https://www.focas-test.fisc.com.tw'
    else
      # 正式站
      expect(Focas.api_base_url).to eq 'https://www.focas.fisc.com.tw'
    end
  end

  describe '* 產生訂單編號' do
    lidm = Focas.create_lidm

    it '* 訂單編號正確產生，且開頭有當下日期、時、分' do
      time_string = Time.now.strftime('%Y%m%d%H%M')
      puts "\t* 訂單編號：#{lidm}"
      expect(lidm.start_with?"#{time_string}").to eq(true)
    end

    it '* 訂單編號在 19 字內' do
      puts "\t* 訂單編號長度：#{lidm.length}"
      expect(lidm.length).to be <= 19
    end
  end

  it '* 取得付費網址(測試站)' do
    request_url = Focas.get_payment_url
    expect(request_url).to eq "#{Focas.api_base_url}/FOCAS_WEBPOS/online/"
  end

  it '* 測試 respToken 沒有亂給' do
    ret = Focas.check_resp_token({})
    expect(ret).to eq false
  end
end
