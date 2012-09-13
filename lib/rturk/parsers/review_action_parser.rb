# Parses a Qualification object

module RTurk
  class ReviewActionParser < RTurk::Parser
    attr_reader :action_id, :action_name, :object_id, :object_type,
                :status, :complete_time, :results, :error_code

    def initialize(review_result_xml)
      @xml_obj = review_result_xml
      map_content(@xml_obj,
                  :action_id => 'ActionId',
                  :action_name => 'ActionName',
                  :object_id => 'ObjectId',
                  :object_type => 'ObjectType',
                  :status => 'Status',
                  :complete_time => 'CompleteTime',
                  :results => 'Results',
                  :error_code => 'ErrorCode' )
    end
  end
end
