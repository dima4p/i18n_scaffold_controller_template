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
  def index
    # @<%= plural_table_name %> = <%= orm_class.all(class_name) %>
<% if defined? Wice::WiceGrid -%>
    @grid = initialize_grid @<%= plural_table_name %>
<% end -%>
  end

  # GET <%= route_url %>/1
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
  def create
<% if Rails.application.config.generators.options[:rails][:cancan] -%>
    # @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
<% else -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>
<% end -%>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_created')
    else
      render action: 'new'
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: t('<%= table_name %>.was_updated')
    else
      render action: 'edit'
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
    redirect_to <%= index_helper %>_url, notice: t('<%= table_name %>.was_deleted')
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

  # Only allow a trusted parameter "white list" through.
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
