class Station
  attr_reader :name, :zone

  def initialize(name, zone)
    raise 'InvalidZone' unless zone.between?(1, 6)
    @name = name
    @zone = zone
  end

end
