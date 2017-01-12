require 'fluent/filter'

module Fluent
  class  DeirdreTestFilter < Filter
    Fluent::Plugin.register_filter('deirdre_test_filter', self)

    def configure(conf)
      super
    end

    def start
      super
    end

    def filter_stream(tag, es)
      new_es =  MultiEventStream.new

      tag_path = tag.gsub "named.var.log.containers.", ''
      /(?<pod_name>[^_]+)_(?<pod_namespace>[^_]+)_(?<pod_ip>\d+\.\d+\.\d+\.\d+)/ =~ tag_path

      es.each {|time, record|
        record['named_file_info'] = {
          'name' => 'hatch'
        }
        record['dkube'] = {
          'tag'       => tag,
          'tag_path'  => tag_path,
          'name'      => pod_name,
          'namespace' => pod_namespace,
          'ip'        => pod_ip
        }
        new_es.add(time, record)
      }

      return new_es
    end


  end
end
