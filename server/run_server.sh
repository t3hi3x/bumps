#!/bin/bash

export CLASSPATH=$CLASSPATH:./jar/*
jython py/bump_server.py
