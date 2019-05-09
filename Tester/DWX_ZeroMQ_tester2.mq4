//+------------------------------------------------------------------+
//|                                           DWX_ZeroMQ_tester2.mq4 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int line_read[][5]; //assign array of intger that will store  columns  rows of csv data
int x=0,n=0,num=0,loop=0,r=0;
int OnInit()
  {
  int filehandle=FileOpen("tester2.bin",FILE_READ|FILE_BIN|FILE_COMMON);
  if(filehandle!=INVALID_HANDLE)
     {
      while(True) //loop through each cell
        {
          int temp = FileReadInteger(filehandle); //read csv cell
          if(FileIsEnding(filehandle)) break; //FileIsEnding = End of File
          num++;//count number of rows
        }
      FileClose(filehandle);
     }
   else Print("Operation FileOpen failed, error ",GetLastError());
//+------------------------------------------------------------------+
//copy the elements of the file in to 2D array
   ArrayResize(line_read,num);
   ResetLastError();
   filehandle=FileOpen("tester2.bin",FILE_READ|FILE_BIN|FILE_COMMON);
   if(filehandle!=INVALID_HANDLE)
     {
     for(int i=0;i<num;i++)
     {
     for(int j=0;j<5;j++)
     {
     line_read[i][j] = FileReadInteger(filehandle);
     }
     }
     FileClose(filehandle);
     }
     else Print("Operation FileOpen failed, error ",GetLastError());
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//testing algorithm (you can put your own testing algorithm)
/*
The algoritm every 1-hour rea a new prediction 
if it has been change close the previous order 
and open a new order.
with error detection 0  0  0  1  0  0
1 is error
*/
int hour,day,month,year;
year=TimeYear(TimeCurrent());
month=TimeMonth(TimeCurrent());
day=TimeDay(TimeCurrent());
hour=TimeHour(TimeCurrent());

if(line_read[loop][0]==year&&line_read[loop][1]==month&&line_read[loop][2]==day &&line_read[loop][3]==hour)//time = time
{
if(n!=0){
if(line_read[x][4]!=line_read[loop][4]&&r==1){
x=0;
r=0;
close();
if(line_read[loop][4]==1)
{
orderbuy();
}
if(line_read[loop][4]==0)
{
ordersell();
}
}
if(line_read[loop-1][4]!=line_read[loop][4]){
x=loop-1;
r=1;
}
}
n++;
loop++;
}
  }
//+------------------------------------------------------------------+
//function that open a buy traede
void orderbuy(){
   int ticket=OrderSend(Symbol(),OP_BUY,0.10,Ask,1,NULL,NULL,NULL,0,0,Green);
   if(ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      Print("OrderSend placed successfully");
}
//+------------------------------------------------------------------+
//function that open a sell traede
void ordersell(){
   int ticket=OrderSend(Symbol(),OP_SELL,0.10,Bid,1,NULL,NULL,NULL,0,0,Red);
   if(ticket<0)
     {
      Print("OrderSend failed with error #",GetLastError());
     }
   else
      Print("OrderSend placed successfully");
}
//+------------------------------------------------------------------+
//function that close traedes
void close(){
  bool ticket;
  for(int i=0;i<OrdersTotal();i++)
  {
   ticket=OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
   if(ticket==true)
     {
   if(OrderType()==OP_BUY)
     {
   ticket=OrderClose(OrderTicket(),OrderLots(),Bid,1);
   if(ticket==true)
     {
        Print("OrderClose placed successfully");
     
     }
   else
     {
      Print("OrderClose failed with error #",GetLastError());
     }
     }
   if(OrderType()==OP_SELL)
     {
   ticket=OrderClose(OrderTicket(),OrderLots(),Ask,1);
   if(ticket==true)
     {
      Print("OrderClose placed successfully");
     }
   else
     {
      Print("OrderClose failed with error #",GetLastError()); 
     }
     }
     }
     }
}
//+------------------------------------------------------------------+