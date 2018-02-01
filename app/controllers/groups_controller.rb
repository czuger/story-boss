class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_current_story

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.where( story_id: @current_story.id ).order( 'name' )
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
    @characters = @current_story.characters
    @selected_character_ids = []
  end

  # GET /groups/1/edit
  def edit
    @characters = @current_story.characters
    @selected_character_ids = @group.characters.pluck(:id)
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    @group.story = @current_story

    respond_to do |format|
      if @group.save
        set_linked_characters

        format.html { redirect_to [ @current_story, @group ], notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        set_linked_characters

        format.html { redirect_to [ @current_story, @group ], notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to story_groups_url(@current_story), notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :desc, :groupe_type)
    end

  def set_linked_characters
    character_ids = params[:character_id]&.to_unsafe_h || []
    to_update_character_ids = character_ids.to_a.map{ |e| e[0].to_i if e[1] == 'true' }.compact

    # We set only the intersection of the requested characters ids and the current story characters ids
    # to avoid characters stealing.
    available_character_ids = @current_story.characters.pluck(:id)
    @group.character_ids = to_update_character_ids & available_character_ids
    @group.save!
  end
end
