require File.join(File.dirname(__FILE__), 'register_hit_type')

module RTurk
  class CreateHIT < RegisterHITType
    attr_accessor :hit_type_id, :assignments, :lifetime, :note
    
    def parse(response)
      RTurk::CreateHITResponse.new(response)
    end

    # Gives us access to a question builder attached to this HIT
    #
    # @param [String, Hash] URL Params, if none is passed, simply returns the question
    # @return [RTurk::Question] The question if instantiated or nil
    def question(*args)
      unless args.empty?
        @question ||= RTurk::Question.new(*args)
      else
        @question
      end
    end

    # Gives us access to a hitReviewPolicy builder attached to this HIT
    #
    # @param [PolicyName, Hash]
    # @return [RTurk::HITReviewPolicy] The HITReviewPolicy if instantiated or nil
    def hit_review_policy(*args)
      unless args.empty?
        @hit_review_policy ||= RTurk::HITReviewPolicy.new(*args)
      else
        @hit_review_policy
      end
    end

    def to_params
      super.merge(
        'HITTypeId'           => hit_type_id, 
        'MaxAssignments'      => (assignments || 1),
        'Question'            => question.to_params,
        'LifetimeInSeconds'   => (lifetime || 3600),
        'RequesterAnnotation' => note,
        'HITReviewPolicy'     => hit_review_policy.to_params
      )
    end

    # More complicated validation run before request
    #
    def validate
      if hit_type_id
        unless question
          raise RTurk::MissingParameters, "When you specify a HitTypeID, you must incude a question"
        end
      else
        super # validate as RegisterHitType
      end
    end
    
    def required_fields
      super << :question
    end
  end

  def self.CreateHIT(*args, &blk)
    RTurk::CreateHIT.create(*args, &blk)
  end
end
