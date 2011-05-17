module Statistics 
  def get_stats
    @statistics ||= Statistic.where(:table_name=>table_name,
                                    :model_id=>id).all
  end

  def get_stat(stat_name)
    get_stats.detect {|s| s.statistic_name == stat_name} || 0
  end
end
