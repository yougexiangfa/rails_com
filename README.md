# RailsCom
Rails 通用基础库，对 Rails 的各个组件进行了扩展。

## 功能模块
* Ruby 核心类扩展，[链接](lib/rails_com/core)
* Rails 核心类扩展
  * ActiveStorage：[链接](lib/rails_com/active_storage) 
    * 通过 url 同步文件；
    * 将文件复制到镜像服务器；
* 支持通过 ACME 自动申请及更新 SSL 证书
* Rails 元信息 : Controller/Model/Routes
* 记录Rails应用报错日志到数据库中，包含出错时的各种详尽信息
  * 支持机器人发送通知
    * 企业微信机器人：`WorkWechatBot`
    * 飞书机器人：`FeishuBot`
* 在开发环境中（Loglevel 为 debug），打印 request headers 信息；

```
Started GET "/admin/log_csps" for 127.0.0.1 at 2018-11-06 15:11:45 +0800
Processing by Log::Admin::LogCspsController#index as HTML
  Headers: {"ACCEPT"=>"text/html, application/xhtml+xml", "ACCEPT_ENCODING"=>"gzip, deflate, br", "ACCEPT_LANGUAGE"=>"en,zh-CN;q=0.9,zh;q=0.8,en-US;q=0.7,zh-TW;q=0.6", "CONNECTION"=>"keep-alive", "HOST"=>"localhost:3000", "IF_NONE_MATCH"=>"W/\"0b91528b7e1207b8a0c59f74361bbb16\"", "REFERER"=>"http://localhost:3000/admin/log_mailers", "TURBOLINKS_CSP_NONCE"=>"usxcEjOGjTjPfcGLmodktA==", "TURBOLINKS_REFERRER"=>"http://localhost:3000/admin/log_mailers", "USER_AGENT"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36", "UTC_OFFSET"=>"-480", "VERSION"=>"HTTP/1.1"}
```
* 为内容安全策略提供 report url

### 工具类
  * UidHelper：基于时间生成 UUID，精确到微秒
  * TimeHelper
  * Jobber
  * IpHelper

## 例子 
[examples](examples)
* puma
* configs

### Locals support

```erb
<%= render 'shared/locales' %>
```

## 支持 enum
```yaml
# zh.yml
activerecord:
  enum:
    notification:
      receiver_type:
        User: 全体用户
        Member: 成员
```

```ruby
t.select :receiver_type, options_for_select(Notification.options_i18n(:receiver_type))
```

* Override 
```yaml
activerecord:
  enum:
    notification:
      receiver_type:
        User: 全体用户
        Member: # remain this blank
```

## 注意
* 仅支持 [webpacker](https://github.com/rails/webpacker)，不再支持 [sprockets](https://github.com/rails/sprockets)

## 版权
遵循 [MIT](https://opensource.org/licenses/MIT) 版权协议
