require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe RTurk::GetReviewResultsForHIT do
  before(:all) do
    faker('get_review_results_for_hit', :operation => 'GetReviewResultsForHIT')
    @response = RTurk.GetReviewResultsForHIT(hit_id: "1234abcd")
  end

  it "should fetch basic information about the hit" do
    @response.hit_id.should == "1234abcd"
    @response.assignment_review_policy.should == "ScoreMyKnownAnswers/2011-09-01"
    @response.hit_review_policy.should == "SimplePlurality/2011-09-01"
  end

  it "should include the assignment review report" do
    @response.assignment_review_report.should_not be_nil
  end

  it "should include the hit review report" do
    @response.hit_review_report.should_not be_nil
  end

  describe "the assignment review report" do
    it "should include review results" do
      @response.assignment_review_report.review_results.length.should == 4
    end

    it "should include review actions" do
      @response.assignment_review_report.review_actions.length.should == 4
    end
  end

  describe "the hit review report" do
    it "should include review results" do
      @response.hit_review_report.review_results.length.should == 21
    end

    it "should include review actions" do
      @response.hit_review_report.review_actions.length.should == 6
    end

    describe ".agreed_answer_found" do
      it "should find the most recent value" do
        @response.hit_review_report.agreed_answer_found.should == true
      end
    end

    describe ".agreed_answer" do
      it "should provide the agreed on answer" do
        @response.hit_review_report.agreed_answer.should == "answer_a"
      end
    end

    describe ".worker_agreement_score" do
      it "gets the latest worker agreement score for a given assignment id" do
        @response.hit_review_report.worker_agreement_score(
          "2WBTUHYW2GTPRVNQANNM469YSA5LQ9"
        ).should == 100

        @response.hit_review_report.worker_agreement_score(
          "2YG2GMMEGOOG8WP5O01A5SEIUGKAA9"
        ).should == 0
      end
    end
  end
end
