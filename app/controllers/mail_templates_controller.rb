class MailTemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mail_template, only: [:show, :edit, :update, :destroy]

  include MailsFromTemplate

  # GET /mail_templates
  def index
    @mail_templates = MailTemplate.all
  end

  # GET /mail_templates/1
  def show
  end

  # GET /mail_templates/new
  def new
    @mail_template = MailTemplate.new
  end

  # GET /mail_templates/1/edit
  def edit
  end

  # POST /mail_templates
  def create
    @mail_template = MailTemplate.new(mail_template_params)
    @mail_template.user = current_user
    substitution_file = params[:mail_template][:substitution_file]

    begin
      build_and_send_mails(substitution_file)
    rescue => e
      logger.error e
      flash[:error] = "An error occured parsing and sending your mails."
    end

    if @mail_template.save
      redirect_to @mail_template, notice: 'Mail template was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /mail_templates/1
  def update
    if @mail_template.update(mail_template_params)
      redirect_to @mail_template, notice: 'Mail template was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /mail_templates/1
  def destroy
    @mail_template.destroy
    redirect_to mail_templates_url, notice: 'Mail template was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_template
      @mail_template = MailTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_template_params
      params.require(:mail_template).permit(:subject, :body)
    end
end
