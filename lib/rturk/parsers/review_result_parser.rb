# Parses a Qualification object

module RTurk
  class ReviewResultParser < RTurk::Parser
    attr_reader :action_id, :subject_id, :object_type, :question_id, :key, :value

    def initialize(review_result_xml)
      @xml_obj = review_result_xml
      map_content(@xml_obj,
                  :action_id => 'ActionId',
                  :subject_id => 'SubjectId',
                  :object_type => 'ObjectType',
                  :question_id => 'QuestionId',
                  :key => 'Key',
                  :value => 'Value')
    end
  end
end
