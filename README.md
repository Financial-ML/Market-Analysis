# Market-Analysis

### Overview

In Market Analysis we build the basics tools that help us to predict the market by connect to MQL4 in a real time from other programing languge , create a dataset by pulling data from the market , Analysis the data using different Machine Learning techniques , and test it in MQL4 with real time trading.

## Components

* [Dataset](#Dataset)

* [ML-Models](#ML-Models)

* [Connection](#Connection)

* [Tester](#Tester)

## Dataset

### Introduction

Create a Dataset for any symbol in any period of time in Forex market that contain this [Features](#Features).

### How we do it
We do it by pulling data from MQL4 in to our CSV file  , the data is pulled using MQL4 build in functions that create our Features.
### Setup
1. Download the code in Dataset [(here)](https://github.com/Financial-ML/Market-Analysis/tree/master/DataSet)
1. Git in the code and write the number of bars you need.
1. Run the script (Dataset) in any symbol and any period of time.
#### Features
"OPEN","CLOSE","HIGH","LOW","VOLUME","MA","STO","FIBO","AC","BUL","ICCI","MACD","RSI","BEAR","AD","ATR","AO","MOM","OSMA","MARKET"
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
## ML-Models

### Introduction
Different Machine Learning models that we used to learn from the [Dataset](#Dataset).

### How we do it
* We build the the models in python using scikit-learn.
* It learn from our predefined [Dataset](#Dataset).
* And save it after finsh traning in PKL file.

### Setup
1. After creating the [Dataset](#Dataset) copy the CSV file in to your python project.
1. Download the code in ML-Models [(here)](https://github.com/Financial-ML/Market-Analysis/tree/master/ML-Models) in to your python project.
2. Run the program and it will generate the PKL file.

## Connection

### Introduction

Connect the strategy that has been developed in Python with MQL4 in a real time connection the structure has been developed by [darwinex-labs](https://github.com/darwinex) you can see their project for installation and more information [(here)](https://github.com/darwinex/dwx-zeromq-connector).

### How we do it
* We have modified the code that has been developed by [darwinex-labs](https://github.com/darwinex) to suit us.
* The structure of the code has developed on Server/Client structure were MQL4-connector is the server and Python-connector is the client.
* We modifie it to receive market data from the server (MQL4) in a live time and predict in the client side (Python) by load the Machine Learning model from [ML-models](#ML-Models).
* Then if we got new prediction send order back to server to close the previous order and open a new order based on the new prediction.

MQL4-connector  :(DWX_ZeroMQ_Connector_v2_0_1_RC8.mq4) the server.

Python-connector:(DWX_ZeroMQ_Connector_v2_0_1_RC8.py) the client.
### Setup
1. Follow ZMQ installation steps in [(here)](https://github.com/darwinex/dwx-zeromq-connector).
1. Download the code in Connect [(here)](https://github.com/Financial-ML/Market-Analysis/tree/master/Connect).
1. Generate the Dataset to use it in ML-Models[(here)](#Dataset).
1. Generate the Model [(here)](#ML-Models).
1. Copy the PKL file in the same Python project of Connect code.
1. Open MQL4 and any python IDE.
1. Load MQL4-connector in MQL4.
1. In Python IDE in console type the following in order:

```
_zmq = DWX_ZeroMQ_Connector(_SUB_PORT=32771)
```

```
_zmq._DWX_MTX_SUBSCRIBE_MARKETDATA_('GOLD')
```

```
_zmq._trader_()
```

**Note:** Make sure that you enable Auto Trading.

## Tester

### Introduction
Tool that use to test the strategy that has been developed outside MQL4 in MQL4.

### How we do it
* The structure of Tester component is complicated because the strategy developed outside MQL4.
* And MQL4 cannot test any strategy developed out side MQL4. 
* What we have done is that we connect from strategy tester in MQL4 with Python-Tester
* And save the prediction and the time in CSV file in a period of time.
* Then convert the file in to a common MQL4 file.
* And test it in MQL4.

MQL4-Tester  :(DWX_ZeroMQ_Server_v2.0.1_RC8.mq4) the server.

Python-Tester:(DWX_ZeroMQ_tester.py) the client.
### Setup
1. Follow ZMQ installation steps in [(here)](https://github.com/darwinex/dwx-zeromq-connector).
1. Download the code in Tester [(here)](https://github.com/Financial-ML/Market-Analysis/tree/master/Tester)
1. Generate the Dataset [(here)](#Dataset) to use it in ML-Models.
1. Generate the Model [(here)](#ML-Models).
1. Copy the PKL file in the same project of Tester code.
1. Open MQL4 and any python IDE.
1. Go to Python IDE in console type the following in order:

```
_zmq = DWX_ZeroMQ_Connector(_SUB_PORT=32771)
```

```
_zmq._DWX_MTX_SUBSCRIBE_MARKETDATA_('GOLD')
```

1. Load MQL4-Tester in MQL4 strategy tester.

1. Go to Python IDE in console type :

```
_zmq._tester_()
```
1. After generate a CSV file copy the file in to MQL4 files directory.
1. Load the converter script.
1. Now test the stratgy by load DWX_ZeroMQ_tester2.mq4 in MQL4 strategy tester

**Note:** The order is important.

