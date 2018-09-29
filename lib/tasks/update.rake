namespace :products do
  desc "created category general in finishes on Project, Block and Unit"
  task measurement_unit: :environment do
    Product.all.each do |product|
      puts product.id
      measurement_id = MeasurementUnit.where(name: product.desc_measurement_unit).first.id
      product.update_attributes(measurement_unit_id: measurement_id)
    end
  end
end