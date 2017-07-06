<source>
  type forward
  port 24224
  bind 0.0.0.0
</source>

<filter docker.**>
  @type parser
  format json
  key_name log
  reserve_data true
</filter>

<match docker.**>
  @type elasticsearch
  host elasticsearch.afdevops.com
  port 9200
  logstash_format true
  logstash_prefix fluentd
  logstash_dateformat %Y%m%d
  include_tag_key true
  type_name cloud
  tag_key @log_name
  flush_interval 1s
</match>
