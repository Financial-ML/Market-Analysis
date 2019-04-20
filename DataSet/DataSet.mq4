//+------------------------------------------------------------------+
//|                                                      DataSet.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
//Call once when initialise the Scripts
void OnStart()
  {
//Market valus
double ma,sto,fibo,ac,bul,ic,macd,rsi,open,close,high,low,bear,ad,atr,ao,mom,osma;
long volume;
int market;
datetime date;
FileDelete("DataSet.csv");
ResetLastError();
//open a file and save market state in it
int filehandle=FileOpen("DataSet.csv",FILE_WRITE|FILE_READ|FILE_CSV,',');
   if(filehandle!=INVALID_HANDLE)
     {
      FileWrite(filehandle,"DATE","OPEN","CLOSE","HIGH","LOW","VOLUME","MA","STO","FIBO","AC","BUL","ICCI","MACD","RSI","BEAR","AD","ATR","AO","MOM","OSMA","MARKET");
      for(int i=3200;i>=2;i--){
      date=iTime(NULL,0,i);
      open=OPEN(i);
      close=CLOSE(i);
      high=HIGH(i);
      low=LOW(i);
      volume=VOLUME(i);
      ma=movingaverge(i);
      sto=Stochastic(i);
      fibo=fibonacci(i);
      ac=AC(i);
      bul=BUL(i);
      ic=ICCI(i);
      macd=MACD(i);
      rsi=RSI(i);
      bear=BEAR(i);
      ad=AD(i);
      atr=ATR(i);
      ao=AO(i);
      mom=MOM(i);
      osma=OSMA(i);
      market=Market(i);
      FileWrite(filehandle,date,open,close,high,low,volume,ma,sto,fibo,ac,bul,ic,macd,rsi,bear,ad,atr,ao,mom,osma,market);
      }
      FileClose(filehandle);
     }
   else Print("Operation FileOpen failed, error ",GetLastError());
   
  }
//+------------------------------------------------------------------+
//Find if the Market was Up or Down buy=1 or sell=0
//+------------------------------------------------------------------+
int Market(int i){
int market=1;
if(Close[i]>=Open[i]){//know what is the market buy or sell
market=1;//buy
}
else if(Close[i]<Open[i]){
market=0;//sell
}
return market;
}
//+------------------------------------------------------------------+
long VOLUME(int i){
return Volume[i];

}
//+------------------------------------------------------------------+
double LOW(int i){
return Low[i];
}
//+------------------------------------------------------------------+
double HIGH(int i){
return High[i];
}
//+------------------------------------------------------------------+
double CLOSE(int i){
return Close[i];
}
//+------------------------------------------------------------------+
double OPEN(int i){
return Open[i];
}
//+------------------------------------------------------------------+
double ICCI(int i){
double ic=iCCI(NULL,0,30,PRICE_CLOSE,i);
return ic;
}
//+------------------------------------------------------------------+
double MACD(int i){
double ic=iMACD(NULL,0,12,26,9,PRICE_CLOSE,MODE_MAIN,i);
return ic;
}
//+------------------------------------------------------------------+
double RSI(int i){
double ic=iRSI(NULL,0,9,PRICE_CLOSE,i);
return ic;
}
//+------------------------------------------------------------------+
double AC(int i){
double ac=iAC(NULL,0,i);
return ac;
}
//+------------------------------------------------------------------+
double BUL(int i){
double bul=iBullsPower(NULL,0,13,PRICE_CLOSE,i);
return bul;
 }
//+------------------------------------------------------------------+
double movingaverge(int i){
double MA=iMA(NULL,0,14,0,MODE_SMA,PRICE_CLOSE,i);
return MA;
}
//+------------------------------------------------------------------+
double Stochastic(int i){
double S=iStochastic(NULL,0,5,3,3,MODE_SMA,0,MODE_MAIN,i);
return S;
}
//+------------------------------------------------------------------+
double fibonacci(int i){
double sta=iSAR(NULL,0,0.02,0.2,i);
return sta;
}
//+------------------------------------------------------------------+
double BEAR(int i){
double bear=iBearsPower(NULL,0,13,PRICE_CLOSE,i);
return bear;
}
//+------------------------------------------------------------------+
double AD(int i){//NEW
double ad=iAD(NULL,0,i);
return ad;
}
//+------------------------------------------------------------------+
double ATR(int i){//NEW
double atr=iATR(NULL,0,14,i);
return atr;
}
//+------------------------------------------------------------------+
double AO(int i){//NEW
double ao=iAO(NULL,0,i);
return ao;
}
//+------------------------------------------------------------------+
double MOM(int i){//NEW
double mom=iMomentum(NULL,0,14,PRICE_CLOSE,i);
return mom;
}
//+------------------------------------------------------------------+
double OSMA(int i){//NEW
double osma=iOsMA(NULL,0,12,26,9,PRICE_CLOSE,i);
return osma;
}
//+------------------------------------------------------------------+