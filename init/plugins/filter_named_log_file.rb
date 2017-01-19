

# FluentD filter meant for use with non-standard logfile collection
# This filter will enrich event metadata with the filename and filepath of the named-logfile

# This filter is expecting that you have set up a shared logging directory by including configuration found in :
# https://github.com/samsung-cnct/shared-logging-directory



require 'fluent/filter'

module Fluent
  class  NamedLogFileFilter < Filter
    Fluent::Plugin.register_filter('named_log_file_filter', self)

    def configure(conf)
      super
    end

    def start
      super
    end

    def filter_stream(tag, es)
      new_es =  MultiEventStream.new

      tag_path = tag.gsub /[^\.]+.var.log.containers./, ''
      /(?<folder>[^_]+_[^_]+_\d+\.\d+\.\d+\.\d+_unknown_unknown)\.(?<filename>.+)/ =~ tag_path
      filepath = "/#{folder}/#{filename}"

      es.each {|time, record|
        record['named_logfile'] = {
          'filepath' => filepath,
          'filename' => filename
        }
        new_es.add(time, record)
      }

      return new_es
    end


  end
end
