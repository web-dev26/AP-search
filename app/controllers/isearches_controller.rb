class IsearchesController < ApplicationController
  REFER = {age: 0..100, salary: 0..1000000.0, height: 0..200, weight: 0..200}
  before_action :set_isearch, only: [:show, :edit, :update, :destroy]
  
  include IsearchesHelper
  include UserHelper

  def index
	@input = Hash[age: (88..100), salary: (5000..500000.0), height: (18..190), weight: (2)]
	
	@id = params[:id]
	
	if @id
	@id = @id.to_i
	end
	
	if @id == 1
			@input = Hash[age: (88..100), salary: (5000..500000.0), height: (18..190), weight: (20)]
	end
	if @id == 2
			@input = Hash[age: (18), salary: (5000..500000.0), height: (18..190), weight: (20..150)]
	end
	if @id == 3
			@input = Hash[age: (88..100), salary: (5000..500000.0)]
	end
	if @id == 4
			@input = Hash[age: (88..100)]
	end
	if @id == 5
			@input = Hash[age: (1), salary: (2), height: (3), weight: (4)]
	end
	@find = Find.new
	@users = []
	@input_temp = @input
	@input = chek_input(@input)
	10000.times { @users.push(User.new)}
	
	@find.tree_data(@users)
	@find_users = @find.search(@input)
	
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_isearch
      @isearch = Isearch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def isearch_params
      params[:isearch]
    end
	
	def chek_input(input)
		ver = input.map do |f, ran|
		next if ran == REFER[f]
			if ran.is_a? Numeric then [f, (ran..ran)]
				else [f, ran]	end	end.compact.flatten 
	Hash[*ver]
	end
    
end
