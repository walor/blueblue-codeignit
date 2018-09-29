module PreventDestroy
  module Model
    def self.included(base)
      base.extend(self)
    end

    def prevent_destroy_if_any(*association_names)
      before_destroy do |model|
        associations_present = []

        association_names.each do |association_name|
          association = model.send association_name
          if association.class == Array
            associations_present << association_name if association.any?
          else
            associations_present << association_name if association
          end
        end

        if associations_present.any?
          errors.add :base, "No puede eliminar #{model.class.model_name.human.downcase} mientras existan: #{associations_present.join ', '}"
          return false
        end

      end
    end
  end
end