# Market-Analysis

### overview

In Market Analysis we build the basics tools that help us to predict the market by connect to MQL4 in a real time from other programing languge , create a dataset by pulling data from the market , Analysis the data using different Machine Learning techniques , and test it in MQL4 with real time trading.

## Components

* [Connection](#Connection)

* [Dataset](#Dataset)

* [ML-Models](#ML-Models)

* [Terster](#Terster)


## Connection

### Introduction

Connect the strategy that has been developed in Python with MQL4 in a real time connection the structure has been developed by [darwinex-labs](https://github.com/darwinex) you can see their project for installation and more information [(here)](https://github.com/darwinex/dwx-zeromq-connector).

### How we do it
I have modified the code that has been developed by [darwinex-labs](https://github.com/darwinex).
The structure of the code has developed on server/client structure were MQL4 is the server and the model that has been developed in Python is the client.
I modifie it to receive market data from the server (MQL4) in a live time and predict in the client side (Python).
Then if we got new prediction send order to server to close the previous  order and open a new order based on the new prediction.

### Setup

## Dataset

### Introduction

Create a Dataset for any symbol in any period of time in Forex market that contain this [features](#Features).

### How we do it

### Setup

#### Features

## ML-Models

### Introduction
Different machine learning models that i used to learn from the [Dataset](#Dataset).

### How we do it

### Setup

## Terster

### Introduction
Tool that use to test the strategy that has been developed outside MQL4 in MQL4.

### How we do it

### Setup

