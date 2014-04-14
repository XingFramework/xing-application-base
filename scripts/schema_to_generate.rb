
module ActiveRecord
  class Schema
    def self.define(_dummy, &block)
      schema = self.new
      schema.instance_eval &block
      puts schema.output
    end

    class Table
      def initialize(name)
        @name = name.sub(/s$/,'')
        @fields = {}
      end

      def fields_string
        @fields.values.map do |field|
          field.values_at(:name, :type).join(":")
        end.join(" ")
      end

      def generate_string
        "rails generate scaffold #@name #{fields_string} --no-migration --skip"
      end

      %i{integer string datetime text boolean float date}.each do |type|
        define_method type do |name, *args|
          @fields[name] = {:name => name, :type => type, :args => args }
        end
      end

      def add_index(field)
        @fields[field][:index] = true
      end
    end

    def initialize
      @tables = {}
      @extras = []
    end

    attr_reader :extras

    def create_table(name, *args)
      t = Table.new(name)
      yield t
      @tables[name] = t
    end

    def add_index(name, fields, *args)
      if fields.length == 1
        @tables[name].add_index(fields.first)
      else
        @extras << [ "add_index #{name.inspect}, #{fields.inspect}",
          *args ].join(", ")
      end
    end

    def output
      @tables.values.map do |table|
        table.generate_string
      end.join("\n")
    end

    def method_missing(name, *args)
      if caller[0].sub(/:.*/,'') == __FILE__
        super
      else
        warn "Method missing: #{name} (#{caller[0]}) - continuing!"
      end
    end
  end
end

load './db/migrate/schema.rb'
