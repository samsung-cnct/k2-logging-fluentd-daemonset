require 'fluent/filter'

module Fluent
  class  DeirdreTestFilter < Filter
    Fluent::Plugin.register_filter('deirdre_test_filter', self)

    def configure(conf)
      super
      # do the usual configuration here
    end

    def start
      super
      # This is the first method to be called when it starts running
      # Use it to allocate resources, etc.
    end


    def filter_stream(tag, es)
      new_es =  MultiEventStream.new

      es.each {|time, record|
        record['hatchimal'] = {
          'id' => "my unique id",
          'name' => "hatch this animal",
          'testcase' => "this is working"
        }
        new_es.add(time, record)
      }

      return new_es
    end


  end
end
