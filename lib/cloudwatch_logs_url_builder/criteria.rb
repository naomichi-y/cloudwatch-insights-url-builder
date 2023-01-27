class CloudWatchLogsUrlBuilder
  class Criteria
    def initialize
      @conditions = []
    end

    def add(key, value)
      case value
      when Array
        result = +encode_key("~#{key}~(")

        value.each do |v|
          result << "#{encode_key("~'")}#{encode_value(v)}"
        end

        @conditions << result + encode_key(')')

      when String
        @conditions << "#{encode_key("~#{key}~'")}#{encode_value(value)}"
      else
        @conditions << "#{encode_key("~#{key}~")}#{encode_value(value)}"
      end
    end

    def build
      "#{encode_key('~(')}#{@conditions.join.delete_prefix(encode_key('~'))}#{encode_key(')')}"
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
