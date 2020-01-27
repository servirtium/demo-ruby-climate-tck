class CurrentContext

  @@listener = nil

  def self.update(ctx)
    @@listener&.updateContext(ctx)
  end

  def self.setListener(listener)
    @@listener = listener
  end

  def self.unSetListener()
    @@listener = nil
  end

end
