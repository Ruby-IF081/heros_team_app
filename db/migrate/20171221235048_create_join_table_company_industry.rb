class CreateJoinTableCompanyIndustry < ActiveRecord::Migration[5.1]
  def change
    create_join_table :companies, :industries do |t|
      t.index [:company_id, :industry_id]
    end
  end
end
