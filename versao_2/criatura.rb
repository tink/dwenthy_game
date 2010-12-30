class Criatura
  # Obtém uma metaclasse para esta classe
  def self.metaclass; class << self; self; end; end

  # Avançado código de metaprogramação para boas
  # e claras características
  def self.caracteristicas( *arr )
    return @caracteristicas if arr.empty?

    # 1. Define 'accessors' para cada variável
    attr_accessor *arr

    # 2. Adiciona um novo método para cada característica.
    arr.each do |a|
      metaclass.instance_eval do
        define_method( a ) do |val|
          @caracteristicas ||= {}
          @caracteristicas[a] = val
        end
      end
    end

    # 3. Para cada monstro o método 'initialize'
    #    deve usar um número padrão para cada característica.
    class_eval do
      define_method( :initialize ) do
        self.class.caracteristicas.each do |k,v|
          instance_variable_set("@#{k}", v)
        end
      end
    end
  end

  # Os atributos da Criatura são somente leitura
  caracteristicas :vida, :forca, :carisma, :arma

  # Este método aplica um golpe recebido durante uma luta.
  def golpear( dano )
    aumento_poder = rand( carisma )
    if aumento_poder % 9 == 7
      @vida += aumento_poder / 4
      puts "[Aumento de poderes mágicos de #{ self.class } #{ aumento_poder }!]"
    end
    @vida -= dano
    puts "[#{ self.class } está morto.]" if @vida <= 0
  end

  # Este método obtém uma rodada em uma luta.
  def lutar( inimigo, arma )
    if vida <= 0
      puts "[#{ self.class } está muito morto para lutar!]"
      return
    end

    # Ataca o oponente
    seu_golpe = rand( forca + arma )
    puts "[Você golpeia com #{ seu_golpe } pontos de dano!]"
    inimigo.golpear( seu_golpe )

    # Retaliação
    p inimigo
    if inimigo.vida > 0
      inimigo_golpe = rand( inimigo.forca + inimigo.arma )
      puts "[Seu inimigo golpeia com #{ inimigo_golpe } pontos de dano!]"
      self.golpear( inimigo_golpe )
    end
  end
end
