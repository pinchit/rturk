require_relative 'review_report_parser'

module RTurk
  class HITReviewReportParser < RTurk::ReviewReportParser
    def agreed_answer_found
      @xml_obj.xpath("ReviewResult[Key='AgreedAnswerFound'][last()]/Value").inner_text == "true"
    end

    def agreed_answer
      el = @xml_obj.xpath('ReviewResult[Key="AgreedAnswer"][last()]/Value')
      el.inner_text unless el.length == 0
    end
  end
end
