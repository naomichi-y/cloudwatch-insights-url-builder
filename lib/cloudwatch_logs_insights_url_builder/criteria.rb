class CloudWatchLogsInsightsUrlBuilder
  class Criteria
    def initialize
      @conditions = []
    end

    def add(key, value)
      case value
      when Array
        result = +encode("~#{key}~(")

        value.each do |v|
          result << "#{encode("~'")}#{encode_value(v)}"
        end

        @conditions << result + encode(')')

      when String
        @conditions << "#{encode("~#{key}~'")}#{encode_value(value)}"
      else
        @conditions << "#{encode("~#{key}~")}#{encode_value(value)}"
      end
    end

    def build
      "#{encode('~(')}#{@conditions.join.delete_prefix(encode('~'))}#{encode(')')}"
    end

    private

    def encode(key)
      URI.encode_www_form_component(URI.encode_www_form_component(key)).gsub('%', '$')
    end

    def encode_value(value)
      URI.encode_www_form_component(value).gsub('%', '*')
    end
  end
end
