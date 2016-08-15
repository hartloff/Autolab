class AddHasAutogradeKeyToAssessment < ActiveRecord::Migration
  def change
    add_column :assessments, :has_autograde, :boolean
    add_column :assessments, :has_partners, :boolean
    add_column :assessments, :has_scoreboard, :boolean
    add_column :assessments, :has_svn, :boolean
		add_column :assessments, :has_lang, :boolean
  end
end
