class XPModel 
 
  # Determines the points required to attain each level.
  # This constant gives a level of 70 at 78000 xp points.
  # 78000 xp points =~ (~500 xp/ex) * (3 ex/week) * (52 week/year)
  LEVEL_CONST = 0.0625

  # Returns the level given the xp points
  def self.level(xp)
    Math.sqrt(XPModel::LEVEL_CONST * xp).ceil()
  end

  # Returns the xp points at the given level
  def self.xp(level)
    ((level ** 2)/XPModel::LEVEL_CONST).ceil()
  end

  # Returns the number of xp points
  # required for earning the next level
  def self.xp_to_next(current_xp)
    xp(level(current_xp) + 1) - current_xp
  end

end
