# This is the main controller to process model <%= class_name %>
#
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController

<% if defined? CanCan -%>
  load_and_authorize_resource
<% else -%>
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
<% end -%>

  # GET <%= route_url %>
  def index
<% unless defined? CanCan -%>
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
<% end -%>
<% if options.with_api? -%>
<% if defined? Wice::WiceGrid -%>
    @grid = initialize_grid @<%= plural_table_name %>
<% end -%>
<% elsif defined?(Wice::WiceGrid) or defined?(Kaminari) -%>
    respond_to do |format|
      format.html do
<% if defined? Wice::WiceGrid -%>
        @grid = initialize_grid @<%= plural_table_name %>
<% end -%>
      end
      format.json do
<% if defined? Kaminari -%>
        @<%= plural_table_name %> = @<%= plural_table_name %>.page(params[:page]) if params[:page].present?
        @<%= plural_table_name %> = @<%= plural_table_name %>.per(params[:per_page]) if params[:per_page].present?
<% end -%>
      end
    end
<% end -%>
  end

  # GET <%= route_url %>/1
  def show
  end

  # GET <%= route_url %>/new
  def new
<% unless defined? CanCan -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
<% end -%>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  def create
<% unless defined? CanCan -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

<% end -%>
<% if options.with_api? -%>
    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_created')
    else
      render :new
<% else -%>
    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_created') }
        format.json { render :show, status: :created, location: @<%= singular_table_name %> }
      else
        format.html { render :new }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
<% end -%>
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
<% if options.with_api? -%>
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_updated')
    else
      render :edit
<% else -%>
    respond_to do |format|
      if @<%= orm_instance.update("#{singular_table_name}_params") %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_updated') }
        format.json { render :show, status: :ok, location: @<%= singular_table_name %> }
      else
        format.html { render :edit }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
<% end -%>
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
<% if options.with_api? -%>
    redirect_to <%= index_helper %>_url, notice: t('<%= table_name %>.was_deleted')
<% else -%>
    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url, notice: t('<%= table_name %>.was_deleted') }
      format.json { head :no_content }
    end
<% end -%>
  end

  private

<% if defined? CanCan -%>
  # Use callbacks to share common setup or constraints between actions.
  # def set_<%= singular_table_name %>
  #   @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  # end
<% else -%>
  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end
<% end -%>

  # Never trust parameters from the scary internet, only allow the white list through.
  def <%= "#{singular_table_name}_params" %>
<%- if attributes_names.empty? -%>
    params.fetch(:<%= singular_table_name %>, {})
<%- else -%>
    list = [
      <%= attributes_names.map { |name| ":#{name}" }.join(', ') %>
    ]
    params.require(:<%= singular_table_name %>).permit(*list)
<%- end -%>
  end
end
<% end -%>
