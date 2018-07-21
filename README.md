# pactera-train-collect
文思大数据培训采集组项目

# 采集方案

## 日志以uid,pageId,actionId,ext组成, 如下:

* uid0001,login_page,btn_login_click,{}
* uid0001,view_page,btn_like,{"target":"uid0002"}

## 采集程序需要将公共参数添加到每个日志间使日志的格式变成uid0001,view_page,btn_like,{"target":"uid0002"},contry,province,city,.......后丢给实时处理/落地hdfs, 如下

* uid0001,login_page,btn_login_click,{},China,SiChuan,ChengDu,...
* uid0001,view_page,btn_like,{"target":"uid0002"},China,SiChuan,ChengDu,...

## 采集程序在采集到type=maillist的时候将公共参数以特定顺序丢入kafka
