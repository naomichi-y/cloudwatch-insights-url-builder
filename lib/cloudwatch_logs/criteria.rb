module AwsUrlBuilder
  class CloudWatchLogs
    class Criteria
      def initialize
        @conditions = []
      end

      def add(key, value)
        if value.kind_of?(Array)
          result = +encode_key("~#{key}~(")

          value.each do |v|
            result << "#{encode_key("~'")}#{encode_value(v)}"
          end

          @conditions << result + encode_key(')')

        elsif value.kind_of?(String)
          @conditions << "#{encode_key("~#{key}~'")}#{encode_value(value)}"
        else
          @conditions << "#{encode_key("~#{key}~")}#{encode_value(value)}"
        end
      end

      def build
        "#{encode_key("~(")}#{@conditions.join.delete_prefix(encode_key('~'))}#{encode_key(')')}"
      end

      private

      def encode_key(key)
        URI.encode_www_form_component(URI.encode_www_form_component(key)).gsub('%', '$')
      end

      def encode_value(value)
        URI.encode_www_form_component(value).gsub('%', '*')
      end
    end
  end
end
