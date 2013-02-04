module BallotsHelper


  def filter_params params
    # TODO filter relevant params that should be editable
    { :id => params[:id], :title => params[:title], :description => params[:description], 
    :end_time => params[:end_time], :public_results => params[:public_results] }
  end

end
