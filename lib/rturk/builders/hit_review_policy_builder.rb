require 'cgi'
require 'uri'

module RTurk
  class HITReviewPolicy
    
    attr_accessor :policy_name, :params

    def initialize(policy_name, params = {})
      @policy_name = policy_name
      self.params = params
    end

    def to_params
      raise RTurk::MissingParameters, "need a policy name to build a hit review policy" unless @policy_name

      map = {
        question_ids: 'QuestionIds',
        question_agreement_threshold: 'QuestionAgreementThreshold',
        disregard_assignment_if_rejected: 'DisregardAssignmentIfRejected',
        disregard_assignment_if_known_answer_score_is_less_than: 'DisregardAssignmentIfKnownAnswerScoreIsLessThan',
        extend_if_hit_agreement_score_is_less_than: 'ExtendIfHITAgreementScoreIsLessThan',
        extend_maximum_assignments: 'ExtendMaximumAssignments',
        extend_minimum_time_in_seconds: 'ExtendMinimumTimeInSeconds',
        approve_if_worker_agreement_score_is_not_less_than: 'ApproveIfWorkerAgreementScoreIsNotLessThan',
        reject_if_worker_agreement_score_is_less_than: 'RejectIfWorkerAgreementScoreIsLessThan',
        reject_reason: 'RejectReason'
      }

      hash = {
        'PolicyName' => policy_name
      }

      i = 1
      params.each do |k,v|
        hash["Parameter.#{i}.Key"] = map[k]
        hash["Parameter.#{i}.Value"] = v
        i += 1
      end

      hash
    end
  end
end
