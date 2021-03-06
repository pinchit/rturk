# <GetReviewResultsForHITResult>
#   <HITId>1AAAAAAAAABBBBBBBBBBCCCCCCCCCC</HITId>
#   <AssignmentReviewPolicy>
#     <PolicyName>ScoreMyKnownAnswers/2011-09-01</PolicyName>
#   </AssignmentReviewPolicy>
#   <HITReviewPolicy>
#     <PolicyName>SimplePlurality/2011-09-01</PolicyName>
#   </HITReviewPolicy>
#   <AssignmentReviewReport>
#     <ReviewResult>
#       <SubjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <QuestionId>Question_2</QuestionId>
#       <Key>KnownAnswerCorrect</Key>
#       <Value>1</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Key>KnownAnswerScore</Key>
#       <Value>100</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <QuestionId>Question_2</QuestionId>
#       <Key>KnownAnswerCorrect</Key>
#       <Value>0</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Key>KnownAnswerScore</Key>
#       <Value>0</Value>
#     </ReviewResult>
#     <ReviewAction>
#       <ActionName>review</ActionName>
#       <ObjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>SUCCEEDED</Status>
#       <Result>Reviewed one known answer; 1/1 correct</Result>
#     </ReviewAction>
#     <ReviewAction>
#       <ActionName>approve</ActionName>
#       <ObjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>SUCCEEDED</Status>
#       <Result>Approved</Result>
#     </ReviewAction>
#     <ReviewAction>
#       <ActionName>review</ActionName>
#       <ObjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>SUCCEEDED</Status>
#       <Result>Reviewed one known answer; 0/1 correct</Result>
#     </ReviewAction>
#     <ReviewAction>
#       <ActionName>reject</ActionName>
#       <ObjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>SUCCEEDED</Status>
#       <Result>Rejected</Result>
#     </ReviewAction>
#   </AssignmentReviewReport>
#   <HITReviewReport>
#     <ReviewResult>
#       <SubjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <QuestionId>Question_1</QuestionId>
#       <Key>AgreedWithPlurality</Key>
#       <Value>1</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</SubjectId>
#       <ObjectType>Assignment</ObjectType>
#       <QuestionId>Question_1</QuestionId>
#       <Key>AgreedWithPlurality</Key>
#       <Value>1</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1AAAAAAAAABBBBBBBBBBCCCCCCCCCC</SubjectId>
#       <ObjectType>HIT</ObjectType>
#       <QuestionId>Question_1</QuestionId>
#       <Key>PluralityAnswer</Key>
#       <Value>true</Value>
#     </ReviewResult>
#     <ReviewResult>
#       <SubjectId>1AAAAAAAAABBBBBBBBBBCCCCCCCCCC</SubjectId>
#       <ObjectType>HIT</ObjectType>
#       <QuestionId>Question_1</QuestionId>
#       <Key>PluralityLevel</Key>
#       <Value>100</Value>
#     </ReviewResult>
#     <ReviewAction>
#       <ActionName>approve</ActionName>
#       <ObjectId>1DDDDDDDDDEEEEEEEEEEFFFFFFFFFF</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>SUCCEEDED</Status>
#       <Result>Already approved</Result>
#     </ReviewAction>
#     <ReviewAction>
#       <ActionName>approve</ActionName>
#       <ObjectId>1GGGGGGGGGHHHHHHHHHHIIIIIIIIII</ObjectId>
#       <ObjectType>Assignment</ObjectType>
#       <Status>FAILED</Status>
#       <Result>Assignment was in an invalid state for this operation.</Result>
#       <ErrorCode>AWS.MechanicalTurk.InvalidAssignmentState</ErrorCode>
#     </ReviewAction>
#   </HITReviewReport>
# </GetReviewResultsForHITResult>

module RTurk
  class GetReviewResultsForHITResponse < Response
    attr_reader :hit_id, :assignment_review_policy, :hit_review_policy

    def initialize(response)
      @raw_xml = response.body
      @xml = Nokogiri::XML(CGI.unescapeHTML(@raw_xml))
      raise_errors
      map_content(@xml.xpath('//GetReviewResultsForHITResult'),
        :hit_id => 'HITId',
        :assignment_review_policy => 'AssignmentReviewPolicy/PolicyName',
        :hit_review_policy => 'HITReviewPolicy/PolicyName'
      )
    end

    def assignment_review_report
      report_xml = @xml.xpath('//AssignmentReviewReport')
      ReviewReportParser.new(report_xml) if report_xml
    end
    
    def hit_review_report
      report_xml = @xml.xpath('//HITReviewReport')
      HITReviewReportParser.new(report_xml) if report_xml
    end
  end
end
