<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class Api::<%= options[:api_version].camelcase + '::' if options[:api_version].present? %><%= controller_class_name %>Controller < ApiController
<% if defined? CanCan -%>
  # before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]
  load_and_authorize_resource
<% else -%>
  before_action :set_<%= singular_table_name %>, only: [:show, :update, :destroy]
<% end -%>

  # GET <%= route_url %>
  def index
<% unless defined? CanCan -%>
    @<%= plural_table_name %> = <%= orm_class.all(class_name) %>

<% end -%>
<% if defined? Kaminari -%>
    @<%= plural_table_name %> = @<%= plural_table_name %>.page(params[:page]) if params[:page].present?
    @<%= plural_table_name %> = @<%= plural_table_name %>.per(params[:per_page]) if params[:per_page].present?
<% end -%>
<% if options.jbuilder? -%>
    render '<%= "/#{plural_table_name}/index.json" %>'
<% else -%>
    render json: <%= "@#{plural_table_name}" %>
<% end -%>
  end

  # GET <%= route_url %>/1
  def show
<% if options.jbuilder? -%>
    render '<%= "/#{plural_table_name}/show.json" %>'
<% else -%>
    render json: <%= "@#{singular_table_name}" %>
<% end -%>
  end

  # POST <%= route_url %>
  def create
<% unless defined? CanCan -%>
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

<% end -%>
    if @<%= orm_instance.save %>
<% if options.jbuilder? -%>
      render '<%= "/#{plural_table_name}/show.json" %>', status: :created, location: <%= "@#{singular_table_name}" %>
<% else -%>
      render json: <%= "@#{singular_table_name}" %>, status: :created, location: <%= "@#{singular_table_name}" %>
<% end -%>
    else
      render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
<% if options.jbuilder? -%>
      render '<%= "/#{plural_table_name}/show.json" %>'
<% else -%>
      render json: <%= "@#{singular_table_name}" %>
<% end -%>
    else
      render json: <%= "@#{orm_instance.errors}" %>, status: :unprocessable_entity
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
    @<%= orm_instance.destroy %>
  end

  private

<% unless defined? CanCan -%>
  # Use callbacks to share common setup or constraints between actions.
  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
  end

<% end -%>
  # Only allow a trusted parameter "white list" through.
  def <%= "#{singular_table_name}_params" %>
<%- if attributes_names.empty? -%>
    params.fetch(:<%= singular_table_name %>, {})
<%- else -%>
    list = %i[
      <%= attributes_names.join(' ') %>
    ]
    params.require(:<%= singular_table_name %>).permit(*list)
<%- end -%>
  end
end
<% end -%>
