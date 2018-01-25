module PlotsHelper

  def character_button_class( character )
    @selected_character_ids.include?( character.id ) ? 'btn-warning' : 'btn-secondary'
  end

end
