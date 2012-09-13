require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))
require 'pry'

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
      @response.hit_review_report.review_results.length.should == 5
    end

    it "should include review actions" do
      @response.hit_review_report.review_actions.length.should == 2
    end

    it "should provide a reader for agreed_answer_found" do
      @response.hit_review_report.agreed_answer_found.should == true
    end

    it "should provide a reader for agreed_answer" do
      @response.hit_review_report.agreed_answer.should == "answer_a"
    end
  end
end
