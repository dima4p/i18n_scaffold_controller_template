# This is the main controller to process model <%= class_name %>
#
<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController

<% if Rails.application.config.generators.options[:rails][:cancan] -%>
  # before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
<% else -%>
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
<% end -%>

  # GET <%= route_url %>
  # GET <%= route_url %>.json
  def index
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    # @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
<% else -%>
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
<% end -%>
<% if defined?(Wice::WiceGrid) or defined?(Kaminari) -%>
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
<% end -%>
    end
  end

  # GET <%= route_url %>/1
  # GET <%= route_url %>/1.json
  def show
  end

  # GET <%= route_url %>/new
  def new
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    # @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
<% else -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
<% end -%>
  end

  # GET <%= route_url %>/1/edit
  def edit
  end

  # POST <%= route_url %>
  # POST <%= route_url %>.json
  def create
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    # @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
<% else -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
<% end -%>

    respond_to do |format|
      if @<%= orm_instance.save %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_created') }
        format.json { render :show, status: :created, location: @<%= singular_table_name %> }
      else
        format.html { render :new }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT <%= route_url %>/1
  # PATCH/PUT <%= route_url %>/1.json
  def update
    respond_to do |format|
      if @<%= orm_instance.update("#{singular_table_name}_params") %>
        format.html { redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_updated') }
        format.json { render :show, status: :ok, location: @<%= singular_table_name %> }
      else
        format.html { render :edit }
        format.json { render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity }
      end
    end
  end

  # DELETE <%= route_url %>/1
  # DELETE <%= route_url %>/1.json
  def destroy
    @<%= orm_instance.destroy %>
    respond_to do |format|
      format.html { redirect_to <%= index_helper %>_url, notice: t('<%= table_name %>.was_deleted') }
      format.json { head :no_content }
    end
  end

  private

<% if Rails.application.config.generators.options[:rails][:cancan] -%>
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
    params[<%= ":#{singular_table_name}" %>]
    <%- else -%>
    list = [
      <%= attributes_names.map { |name| ":#{name}" }.join(', ') %>
    ]
    params.require(<%= ":#{singular_table_name}" %>).permit(*list)
    <%- end -%>
  end
end
<% end -%>
