MovementType.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('movement_types')



MovementType.create!(name: 'Saldo Inicial', type_process: 'inicial', signal: +1)
MovementType.create!(name: 'Orden de Compra',  type_process: 'entrada', signal: +1)
MovementType.create!(name: 'Salida Orden de Compra',  type_process: 'salida', signal: -1)
MovementType.create!(name: 'Salida a Oficinas',  type_process: 'salida', signal: -1)
MovementType.create!(name: 'Devolucion a Proveedor', type_process: 'salida', signal: -1)
MovementType.create!(name: 'Devolucion a Almacen',  type_process: 'entrada', signal: +1)
MovementType.create!(name: 'Donacion',  type_process: 'entrada', signal: +1)
MovementType.create!(name: 'Transferencia entre Almacenes',  type_process: 'entrada', signal: -1)
MovementType.create!(name: 'Transferencia entre Almacenes',  type_process: 'salida', signal: +1)
MovementType.create!(name: 'Ajuste de Inventario',  type_process: 'entrada', signal: +1)
MovementType.create!(name: 'Ajuste de Inventario',  type_process: 'salida', signal: -1)
MovementType.create!(name: 'De Baja',  type_process: 'salida', signal: -1)
MovementType.create!(name: 'Compra',  type_process: 'entrada', signal: +1) #por nota de entrada


MeasurementUnit.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('measurement_units')

measurement_units = Product.pluck(:desc_measurement_unit).uniq
measurement_units.each do |measurement_unit|
  MeasurementUnit.create!(name: measurement_unit, active: true)
end