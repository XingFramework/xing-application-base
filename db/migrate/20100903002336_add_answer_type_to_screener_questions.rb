class AddAnswerTypeToScreenerQuestions < ActiveRecord::Migration
  def self.up
    add_column :screener_questions, :answer_type, :integer, :default => 0
  end

  def self.down
    remove_column :screener_questions, :answer_type
  end
end
