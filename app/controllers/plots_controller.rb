class PlotsController < ApplicationController
  before_action :set_plot, only: [:show, :edit, :update, :destroy]
  before_action :set_current_story

  # GET /plots
  # GET /plots.json
  def index
    @plots = Plot.where( story_id: @current_story.id ).order( 'name' )
  end

  # GET /plots/1
  # GET /plots/1.json
  def show
    @nodes = [ { id: 'plot_' + @plot.id.to_s, group: '1', name: @plot.name } ]
    @plot.characters.each do |c|
      link_item( 'plot_' + @plot.id.to_s, { id: 'char_' + c.id.to_s, group: '2', name: c.name } )
    end

    @plot.characters.each do |c|
      c.groups.each do |group|
        @nodes << { id: 'group_' + group.id.to_s, group: '3', name: group.name }
        @links << { source: 'char_' + c.id.to_s, target: 'group_' + group.id.to_s, value: 1 }

        group.characters.each do |connected_c|
          link_item( 'group_' + group.id.to_s, { id: 'char_' + connected_c.id.to_s, group: '2', name: connected_c.name } )
        end
        
      end
    end

    @graph = { nodes: @nodes, links: @links }
  end

  # GET /plots/new
  def new
    @plot = Plot.new
    @characters = @current_story.characters
    @selected_character_ids = []
  end

  # GET /plots/1/edit
  def edit
    @characters = @current_story.characters
    @selected_character_ids = @plot.characters.pluck(:id)
  end

  # POST /plots
  # POST /plots.json
  def create
    @plot = Plot.new(plot_params)
    @plot.story = @current_story

    respond_to do |format|
      if @plot.save
        set_linked_characters

        format.html { redirect_to [ @current_story, @plot ], notice: 'Plot was successfully created.' }
        format.json { render :show, status: :created, location: @plot }
      else
        format.html { render :new }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plots/1
  # PATCH/PUT /plots/1.json
  def update
    respond_to do |format|
      if @plot.update(plot_params)
        set_linked_characters

        format.html { redirect_to [@current_story, @plot], notice: 'Plot was successfully updated.' }
        format.json { render :show, status: :ok, location: @plot }
      else
        format.html { render :edit }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plots/1
  # DELETE /plots/1.json
  def destroy
    @plot.destroy
    respond_to do |format|
      format.html { redirect_to story_plots_path(@current_story), notice: 'Plot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plot
      @plot = Plot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plot_params
      params.require(:plot).permit( :name, :desc )
    end

    def set_linked_characters
      character_ids = params[:character_id]&.to_unsafe_h || []
      to_update_character_ids = character_ids.to_a.map{ |e| e[0].to_i if e[1] == 'true' }.compact
      available_character_ids = @current_story.characters.pluck(:id)

      raise "Trying to link unpermitted characters to_update_character_ids = #{to_update_character_ids}, available_characters_ids = #{available_character_ids}" unless ( to_update_character_ids - available_character_ids ).empty?
      @plot.character_ids = to_update_character_ids
      @plot.save!
    end

    def link_item( source_id, data )
      @items_already_in_graph ||= []
      @links ||= []

      return if @items_already_in_graph.include?( data[:id ] )

      @nodes << data
      @links << { source: source_id, target: data[:id], value: 1 }
      @items_already_in_graph << data[:id ]
    end
end
