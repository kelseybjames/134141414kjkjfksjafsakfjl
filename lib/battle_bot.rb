class BattleBot
  @@count = 0
  attr_reader :name, :health, :enemies, :weapon
  attr_accessor :count

  def initialize(name, health=100)
    @name = name
    @health = health
    @enemies = []
    @weapon = nil
    @@count += 1
  end

  def pick_up(new_weapon)
    raise ArgumentError.new("Not a weapon!") unless new_weapon.is_a?(Weapon)
    raise ArgumentError.new("Already picked up") unless new_weapon.bot == nil
    if @weapon == nil
      @weapon = new_weapon
      @weapon.bot = self
      return @weapon
    end
  end

  def drop_weapon
    @weapon.bot = nil
    @weapon = nil
  end

  def heal
    @health = [100, @health + 10].min if @health > 0
    @health
  end

  def attack(robot)
    raise ArgumentError.new("Opponent must be a robot") unless robot.is_a?(BattleBot)
    raise ArgumentError.new("You can't attack yourself!") if robot == self
    raise ArgumentError.new("You have no weapon!") if @weapon == nil
    
    robot.receive_attack_from(self)
  end

  def receive_attack_from(robot)
    raise ArgumentError.new("Opponent must be a robot") unless robot.is_a?(BattleBot)
    raise ArgumentError.new("You can't attack yourself!") if robot == self
    raise ArgumentError.new("Opponent has no weapon!") if robot.weapon == nil

    take_damage(robot.weapon.damage)
    @enemies << robot unless @enemies.include?(robot)
    defend_against(robot)
  end

  def take_damage(number)
    raise ArgumentError.new("Damage must be a number") unless number.is_a?(Fixnum)
    @health = [0, @health - number].max
  end

  def defend_against(robot)
    if (!robot.dead? && robot.has_weapon?)
      attack(robot)
    end
  end

  def dead?
    if @health == 0
      @@count -= 1
      return true
    end
    false
  end

  def has_weapon?
    @weapon == nil ? false : true
  end
end