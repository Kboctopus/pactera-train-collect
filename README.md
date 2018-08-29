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

### 用户基本信息表: user_status (Hbase), 用于大数据内部计算
* rowKey: md5(uid)
* cf: 0

| rowKey | cf | value |
| -------- | -------- | -------- |
| 12378617     | 0:country     | China     |
| 12378617     | 0:city     | ChengDu     |
| 12378617     | 0:channel     | appStore     |
| 12378617     | 0:rom     | 6.3     |
| ...     | 0:...     | ...     |


### 离线统计结果表: user_action_result_daily(mySql), 用于后台管理查看按天的行为统计

| date | coutry | province | count | user_count | pageid | actionid |
| -------- | -------- | -------- | -------- | -------- | -------- | -------- |
| Text     | Text     | Text     | Number     | Number     | Text     | Text     |


### 实时统计结果表: user_action_result_realtime(待定), 用于后台管理查看实时的行为统计

| time | coutry | province | count  | pageid | actionid |
| -------- | -------- | -------- | --------  | -------- | -------- |
| ts     | Text     | Text     | Number   | Text     | Text     |







