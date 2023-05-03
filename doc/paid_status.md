## 刷卡成功 callback 範例

   {
      "errcode"=>"00",
      "authCode"=>"AB1234",
      "authRespTime"=>"20230502200708",
      "lastPan4"=>"5101",
      "amtExp"=>"0",
      "xid"=>"xxx",
      "errDesc"=>"",
      "lidm"=>"xxx",
      "authAmt"=>"5000",
      "currency"=>"",
      "merID"=>"xxx",
      "cardBrand"=>"VISA",
      "pan"=>"490706******5101",
      "status"=>"0",
      "controller"=>"xxx",
      "action"=>"xxx"
   }


## 刷卡失敗 callback 範例

   {
      "errcode"=>"91",
      "authCode"=>"",
      "authRespTime"=>"20230503112403",
      "lastPan4"=>"5101",
      "amtExp"=>"0",
      "xid"=>"xxx",
      "errDesc"=>"%B1%C2%C5v%A5%A2%B1%D1", #(big5?)
      "lidm"=>"xxx",
      "authAmt"=>"10000",
      "currency"=>"",
      "merID"=>"xxx",
      "cardBrand"=>"VISA",
      "pan"=>"490706******5101",
      "status"=>"8"
   }
