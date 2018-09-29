module ApplicationHelper

	def nav_link(link_text, link_path)
	  class_name = current_page?(link_path) ? 'active' : ''

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end

	def active_menu(ctl_name)
		'active' if controller_name == ctl_name
	end

	def show_link(path)
		link_to '<i class="icon-eye-open"></i>'.html_safe, path
	end

	def print_link(path)
		link_to '<i class="icon-print"></i>'.html_safe, polymorphic_url(path, format: :pdf), target: :new
	end

	def edit_link(path)
		link_to '<i class="icon-pencil"></i>'.html_safe, path
	end

	def edit_button(path)
		link_to '<i class="icon-pencil"></i> Editar'.html_safe, path, class: 'btn'
	end

	def print_button(path)
		link_to '<i class="icon-print"></i> Imprimir'.html_safe, polymorphic_url(path, format: :pdf), target: :new, class: 'btn'
	end

	def destroy_link(path)
		link_to '<i class="icon-trash"></i>'.html_safe, path, method: :delete, data: { confirm: t(:sure) }
	end

	def destroy_button(path)
		link_to '<i class="icon-trash"></i> Eliminar'.html_safe, path, method: :delete, data: { confirm: t(:sure) }, class: 'btn'
	end

	def link_to_add_fields(name, f, association, p = nil)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, idx: '')
    end
    link_to_function(name.html_safe, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", class: "btn btn-add", role: "button")
	end

	# def link_to_add_fields(name, f, association)
 #    new_object = f.object.send(association).klass.new
 #    id = new_object.object_id
 #    fields = f.fields_for(association, new_object, child_index: id) do |builder|
 #      render(association.to_s.singularize + "_fields", f: builder)
 #    end
 #    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
 #  end
end