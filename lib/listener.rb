class Listener
  
  # These are the funny listeners.  Segregated so we can turn them off if it gets annoying down the road.
  FUNNY =
    [/\smom\s/i, "Hey now, no reason to drag someone's mom into this."],
    [/\sFort Wayne\s/i, "Fort Wayne FTW!"],
    [/\sgem\s/i, "Oooooh shiny!!!"]
    
  # Other categories here?
  
  # Grab all. Concat other sections here when added
  def self.all
    FUNNY
  end
  
end