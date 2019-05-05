//+------------------------------------------------------------------+
//|                                                    Convertor.mq4 |
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
   int line_read[][5]; //assign array of integer that will store  columns  rows of csv data
   int loop=0,num=0;
   int row=0,col=0; //column and row pointer for the array
void OnStart()
  {
      int handle=FileOpen("tester.csv",FILE_CSV|FILE_READ,","); //comma delimiter
      if(handle>0)
      {
        while(True) //loop through each cell
        {
          int temp = FileReadString(handle); //read csv cell
          if(FileIsEnding(handle)) break; //FileIsEnding = End of File
          num++;//count number of rows
        }
        FileClose(handle);
      }
      else
      {
        Comment("File  not found, the last error is ", GetLastError());
      }  
//+------------------------------------------------------------------+
      ArrayResize(line_read,num);
      ResetLastError();
      int handle2=FileOpen("tester.csv",FILE_CSV|FILE_READ,","); //comma delimiter
      if(handle2>0)
      {
        while(True) //loop through each cell
        {
          int temp = FileReadString(handle2); //read csv cell
          if(FileIsEnding(handle2)) break; //FileIsEnding = End of File
          line_read[row][col]=temp; //save reading result to array
          if(FileIsLineEnding(handle2)) //FileIsLineEnding = End of Line
          {
            col = 0; //reset col = 0 for the next row
            row++; //next row
          }
          else
          {
            col++; //next col of the same row
          }
        }
        FileClose(handle2);
      }
      else
      {
        Comment("File  not found, the last error is ", GetLastError());
      }  
//+------------------------------------------------------------------+
//copy the csv file to file common to be easy to teast
   ResetLastError();
   int filehandle=FileOpen("tester2.bin",FILE_WRITE|FILE_BIN|FILE_COMMON);
   if(filehandle!=INVALID_HANDLE)
     {
     Print("FileOpen OK");
     for(int i=0;i<num;i++)
     {
     for(int j=0;j<5;j++)
     FileWriteInteger(filehandle,line_read[i][j]);
     }
     FileClose(filehandle);
     }
   else Print("Operation FileOpen failed, error ",GetLastError());
  }
//+------------------------------------------------------------------+
