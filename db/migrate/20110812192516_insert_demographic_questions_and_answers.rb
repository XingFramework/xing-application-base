class InsertDemographicQuestionsAndAnswers < ActiveRecord::Migration
  def self.up
    q1 = DemoQuestion.create(:text=>"What is your race? (check all that apply)", :multiple=>true)
    q1.answers.create :text=>"Black or African"
    q1.answers.create :text=>"East Asian"
    q1.answers.create :text=>"Hispanic"
    q1.answers.create :text=>"Indigenous"
    q1.answers.create :text=>"Middle Eastern"
    q1.answers.create :text=>"Pacific Islander"
    q1.answers.create :text=>"South Asian"
    q1.answers.create :text=>"White or European"

    q2 = DemoQuestion.create :text=>"Do you have any children?"
    q2.answers.create :text=>"Yes"
    q2.answers.create :text=>"No"
    q2.answers.create :text=>"Prefer not to say"

    q3 = DemoQuestion.create :text=>"What is your annual household income?"
    q3.answers.create :text=>"Less than $30k"
    q3.answers.create :text=>"$30k-$50k"
    q3.answers.create :text=>"$50k-$75k"
    q3.answers.create :text=>"$75k-$100k"
    q3.answers.create :text=>"Over $100k"
    q3.answers.create :text=>"Prefer not to say"

    q4 = DemoQuestion.create :text=>"What is your sexual orientation?"
    q4.answers.create :text=>"Heterosexual"
    q4.answers.create :text=>"Homosexual"
    q4.answers.create :text=>"Bisexual"
    q4.answers.create :text=>"Transgendered"
    q4.answers.create :text=>"Other"
    q4.answers.create :text=>"Prefer not to say"

    q5 = DemoQuestion.create :text=>"What is your highest level of education?"
    q5.answers.create :text=>"Have not completed high school"
    q5.answers.create :text=>"High school or GED"
    q5.answers.create :text=>"Associates degree"
    q5.answers.create :text=>"Bachelors degree"
    q5.answers.create :text=>"Master's degree"
    q5.answers.create :text=>"Doctoral degree"
    q5.answers.create :text=>"Prefer not to say"

    q6 = DemoQuestion.create(:text=>"Do you have any specialized professional degrees? (check all that apply)", :multiple=>true)
    q6.answers.create :text=>"MD"
    q6.answers.create :text=>"MBA"
    q6.answers.create :text=>"JD"

    q7 = DemoQuestion.create(:text=>"Do you own any of these smartphones/tablets? (check all that apply)", :multiple=>true)
    q7.answers.create :text=>"Apple iPhone 4"
    q7.answers.create :text=>"Apple iPhone 3GS or older"
    q7.answers.create :text=>"Apple iPad 2"
    q7.answers.create :text=>"Android phone (with a front-facing camera)"
    q7.answers.create :text=>"Android phone (no front-facing camera)"
    q7.answers.create :text=>"Android tablet (with a front-facing camera)"
    q7.answers.create :text=>"Android tablet (no front-facing camera)"
    q7.answers.create :text=>"Other smartphone (with a front-facing camera)"
    q7.answers.create :text=>"Other smartphone (no front-facing camera)"
  end

  def self.down
  end
end
