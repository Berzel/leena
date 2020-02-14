#!/bin/bash

consul-template -once -consul-addr=consul:8500 -template="/etc/nginx/nginx.conf.ctmpl:/etc/nginx/nginx.conf"