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

    # def get_log_directory(arr)
    #   arr.each do |f|
    #    if (!f.match /.log\z/) && (!f.match /\A\./)
    #     return f
    #    end
    #   end
    # end
    #
    # def get_filename(arr)
    #   arr.each do |f|
    #     if !f.match /\A\./
    #       return f
    #     end
    #   end
    # end


    def filter_stream(tag, es)
      new_es =  MultiEventStream.new
      # entries = Dir.entries("/var/log/containers/")
      # filepath = get_log_directory(entries)
      # log_file = Dir.entries("/var/log/containers/#{filepath}")
      # filename = get_filename(log_file)

      # tag_path = tag.gsub "named.var.log.containers.", '/'
      # file = (tag_path.scan  /\.\w+\.\w+\Z/)[0]
      # file[0] = '/'
      # tag_regex = tag_path.gsub /\.\w+\.\w+\Z/ , file
      # str = "named.var.log.containers.log-generator_default_10.128.76.4.all_logs.txt"

      tag_path = tag.gsub "named.var.log.containers.", ''
      # tag_path == "log-generator_default_10.128.76.4.all_logs.txt"
      # arry = tag_path.scan /[^_]+/
      /(?<pod_name>[^_]+)_(?<pod_namespace>[^_]+)_(?<pod_ip>\d+\.\d+\.\d+\.\d+)/ =~ tag_path

      es.each {|time, record|
        record['named_file_info'] = {
          'name'            => 'hatch'
        }
        record['kube'] = {
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
