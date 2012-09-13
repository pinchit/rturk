module RTurk
  class ReviewReportParser < RTurk::Parser
    def initialize(report_xml)
      @xml_obj = report_xml
    end

    def review_results
      @review_results ||= @xml_obj.xpath('ReviewResult').map do |xml|
        ReviewResultParser.new(xml)
      end
    end

    def review_actions
      @review_actions ||= @xml_obj.xpath('ReviewAction').map do |xml|
        ReviewActionParser.new(xml)
      end
    end
  end
end
