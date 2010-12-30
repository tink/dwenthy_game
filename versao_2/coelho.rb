class Coelho < Criatura
  caracteristicas :bombas

  vida 10
  forca 2
  carisma 44
  arma 4
  bombas 3

  # bumeranguinho
  def ^( inimigo )
    lutar( inimigo, 13 )
  end
  # a espada do herói é ilimitada!!
  def /( inimigo )
    lutar( inimigo, rand( 4 + ( ( inimigo.vida % 10 ) ** 2 ) ) )
  end
  # alface irá formar a sua força e fibra alimentar extra
  # voará na cara de seu oponente!!
  def %( inimigo )
    alface = rand( carisma )
    puts "[Alface saudável lhe dá #{ alface } pontos de vida!!]"
    @vida += alface
    lutar( inimigo, 0 )
  end
  # bombas, mas você possui somente três!!
  def *( inimigo )
    if @bombas.zero?
      puts "[HUMM!! Você está sem bombas!!]"
      return
    end
    @bombas -= 1
    lutar( inimigo, 86 )
  end
end
