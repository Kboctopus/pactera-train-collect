--引入lua所有api  
--获取POST数据
 local cjson = require "cjson"  
 local producer = require "resty.kafka.producer"  
--定义kafka broker地址，ip需要和kafka的host.name配置一致  
 local broker_list = {  
     { host = "192.168.1.204", port = 9092 },  
 }  
--定义json便于日志数据整理收集  
 local log_json = {}   

local f=io.open("/opt/openresty/nginx/logs/3.log","a+")
local type = ngx.req.get_uri_args()["type"]


--log_json["list"] = list[1]
--http://xxx.xxx.com/appDataUpload?uid=asas&type=action&maillist=A:23,B:3234,C:42234&gps=3123.23342,324234.345345&xxx=xxx&xxx&xxx&型号=XX&系统版本=2.3

log_json["uid"] = ngx.req.get_uri_args()["uid"] or 0
log_json["type"] = ngx.req.get_uri_args()["type"] or 0
log_json["maillist"] = ngx.req.get_uri_args()["maillist"] or 0
log_json["gps"] = ngx.req.get_uri_args()["maillist"] or 0

--转换json为字符串  
 local message = cjson.encode(log_json);  

--定义kafka异步生产者  
local bp = producer:new(broker_list, { producer_type = "async" })

--发送日志消息,send第二个参数key,用于kafka路由控制:  
local ok=""
local err=""
if type == "action" and ngx.var.request_body then
	local userAction = ngx.var.request_body or ''
	ok, err = bp:send("userAction", nil, userAction)  
end;

if type == "maillist" then
	ok, err = bp:send("access-log", nil, message)
end;

 if not ok then  
     ngx.log(ngx.ERR, "kafka send err:", err)  
     return  
 end  