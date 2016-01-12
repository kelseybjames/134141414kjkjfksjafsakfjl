class Weapon
  attr_reader :name, :damage, :bot

  def initialize(name, damage=10)
    raise ArgumentError.new("Name must be a string") unless name.is_a?(String)
    raise ArgumentError.new("Damage must be a number") unless damage.is_a?(Fixnum)
    @name = name
    @damage = damage
    @bot = nil
  end

  def bot=(bot)
    raise ArgumentError.new("I am NOT a robot!") unless bot.is_a?(BattleBot) || bot == nil
    @bot = bot
  end

  def picked_up?
    @bot == nil ? false : true
  end
end