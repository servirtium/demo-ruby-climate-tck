class CurrentContext

  def self.update(ctx)
    # This needs to be passed to the Servirtium playbacker so that it knows which markdown to load
    if @@listener
      @@listener.updateContext(ctx)
    end
  end

  def self.setListener(listener)
    @@listener = listener
  end

  def self.unSetListener()
    @@listener = nil
  end

end
