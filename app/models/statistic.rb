# Represents statistics on specific tables and columns

class Statistic < ActiveRecord::Base
  validates :model_table_name, :model_id, :statistic_name, :presence=>true
end
