class MyControllerController < ApplicationController
 def index
    @my_controller = My_Controller.all
  end

  def new
    @my_controller = My_Controller.new
  end

  def create
    @my_controller = My_Controller.new(resume_params)

    if @my_controller.save
      redirect_to resumes_path, notice: "The resume #{@resume.name} has been uploaded."
    else
      render "new"
    end
  end

  def destroy
    @my_controller = My_Controller.find(params[:id])
    @my_controller.destroy
    redirect_to resume_path, notice:  "The resume #{@resume.name} has been deleted."
  end

  def myController
  end
private
  def my_controller_params
    params.require(:resume).permit(:name, :attachment)
  end 
end
