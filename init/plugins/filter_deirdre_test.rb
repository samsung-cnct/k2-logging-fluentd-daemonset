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

      #'named' is current tag set in fluent.conf
      # if tag is changed, tag_path will need to change to match
      tag_path = tag.gsub "named.var.log.containers.", ''
      /(?<pod_name>[^_]+)_(?<pod_namespace>[^_]+)_(?<pod_ip>\d+\.\d+\.\d+\.\d+)/ =~ tag_path
      /(?<folder>[^_]+_[^_]+_\d+\.\d+\.\d+\.\d+)_unknown_unknown\.(?<filename>.+)/ =~ tag_path
      filepath = "/#{folder}/#{filename}"

      es.each {|time, record|
        record['named_file_info'] = {
          'filepath' => filepath,
          'filename' => filename
        }
        new_es.add(time, record)
      }

      return new_es
    end


  end
end
