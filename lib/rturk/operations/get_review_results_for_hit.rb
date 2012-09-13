module RTurk
  class GetReviewResultsForHIT < Operation

    require_params :hit_id
    attr_accessor :hit_id, :include_assignment_summary

    def parse(xml)
      RTurk::GetReviewResultsForHITResponse.new(xml)
    end

    def to_params
      {"HITId" => self.hit_id}
    end

  end

  def self.GetReviewResultsForHIT(*args, &blk)
    RTurk::GetReviewResultsForHIT.create(*args, &blk)
  end
end
