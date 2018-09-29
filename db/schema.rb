# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140717015241) do

  create_table "agents", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "maiden_name"
    t.string   "position"
    t.string   "email"
    t.string   "phone"
    t.integer  "provider_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
  end

  create_table "brands", :force => true do |t|
    t.string   "description"
    t.text     "observation"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "name"
    t.string   "long_description"
    t.integer  "group_id"
    t.integer  "sub_group_id"
  end

  create_table "categories", :force => true do |t|
    t.integer  "type_category"
    t.string   "name"
    t.string   "description"
    t.integer  "sub_group_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "categories", ["name", "type_category"], :name => "index_categories_on_name_and_type_category", :unique => true

  create_table "generic_products", :force => true do |t|
    t.integer  "category_id"
    t.string   "name"
    t.string   "description"
    t.string   "measurement_unit"
    t.integer  "generic_product_type"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "groups", :force => true do |t|
    t.integer  "type_group"
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "input_note_details", :force => true do |t|
    t.integer  "input_note_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.text     "product_description"
    t.float    "quantity",                                          :default => 1.0
    t.decimal  "price_unit",          :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "price_total",         :precision => 8, :scale => 2, :default => 0.0
    t.integer  "outgoing",                                          :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
    t.string   "model"
    t.string   "detail"
    t.integer  "brand_id"
  end

  create_table "input_notes", :force => true do |t|
    t.string   "name"
    t.integer  "provider_id"
    t.date     "date"
    t.float    "sub_total",           :default => 0.0
    t.float    "total",               :default => 0.0
    t.integer  "status"
    t.integer  "emisor_id"
    t.integer  "receiver_id"
    t.string   "doc_ref"
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.integer  "ware_house_id"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.text     "observation"
    t.string   "serial"
    t.integer  "movement_type_id"
    t.integer  "type_input_note"
    t.integer  "document_type"
    t.string   "destination"
    t.integer  "area_origin_id"
    t.integer  "area_destination_id"
  end

  create_table "measurement_units", :force => true do |t|
    t.string   "name"
    t.string   "unit"
    t.boolean  "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "movement_items", :force => true do |t|
    t.integer  "movement_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.float    "quantity",             :default => 0.0
    t.float    "price_unit",           :default => 0.0
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.float    "price_total",          :default => 0.0
    t.integer  "pending_quantity"
    t.integer  "purchase_detail_id"
    t.integer  "input_note_detail_id"
    t.integer  "brand_id"
    t.string   "model"
    t.string   "detail"
  end

  create_table "movement_types", :force => true do |t|
    t.string   "name"
    t.integer  "signal"
    t.string   "type_process"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "movements", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.integer  "provider_id"
    t.integer  "ware_house_id"
    t.integer  "movement_type_id"
    t.float    "quantity"
    t.integer  "emisor_id"
    t.integer  "receiver_id"
    t.integer  "status"
    t.float    "price_unit"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "purchase_order_id"
    t.string   "doc_ref"
    t.string   "invoice_number"
    t.datetime "invoice_date"
    t.integer  "input_note_id"
    t.text     "observation"
    t.string   "serial"
    t.integer  "document_type"
    t.string   "receiver"
  end

  add_index "movements", ["movement_type_id"], :name => "index_movements_on_movement_type_id"
  add_index "movements", ["ware_house_id"], :name => "index_movements_on_ware_house_id"

  create_table "product_ware_houses", :force => true do |t|
    t.integer  "product_id"
    t.integer  "ware_house_id"
    t.float    "current_stock",  :default => 0.0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.float    "implicate",      :default => 0.0
    t.float    "count_physical", :default => 0.0
    t.float    "avg_price"
  end

  add_index "product_ware_houses", ["product_id"], :name => "index_product_ware_houses_on_product_id"
  add_index "product_ware_houses", ["ware_house_id"], :name => "index_product_ware_houses_on_ware_house_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "stock_min"
    t.float    "stock_max"
    t.float    "avg_price"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.integer  "restock"
    t.integer  "measurement_unit_id"
    t.integer  "category_id"
    t.integer  "group_id"
    t.integer  "sub_group_id"
    t.integer  "type_product"
    t.string   "desc_measurement_unit"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "resposible"
    t.string   "ruc"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.string   "last_name"
    t.string   "maiden_name"
    t.string   "fax"
    t.string   "email"
    t.string   "web"
    t.string   "cellphone"
    t.string   "observations"
    t.integer  "type_company"
    t.integer  "category_id"
    t.integer  "type_provider", :default => 1
    t.string   "first_name"
    t.integer  "group_id"
    t.integer  "sub_group_id"
    t.string   "position"
  end

  create_table "purchase_details", :force => true do |t|
    t.integer  "purchase_order_id"
    t.integer  "product_id"
    t.string   "product_name"
    t.text     "product_description"
    t.float    "quantity",            :default => 1.0
    t.float    "price_unit",          :default => 0.0
    t.float    "price_total",         :default => 0.0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.integer  "pending_quantity"
    t.integer  "incoming"
    t.integer  "outgoing"
    t.string   "model"
    t.string   "detail"
    t.integer  "brand_id"
  end

  add_index "purchase_details", ["product_id"], :name => "index_purchase_details_on_product_id"
  add_index "purchase_details", ["purchase_order_id"], :name => "index_purchase_details_on_purchase_order_id"

  create_table "purchase_orders", :force => true do |t|
    t.string   "name"
    t.integer  "provider_id"
    t.date     "date"
    t.float    "sub_total",        :default => 0.0
    t.float    "total",            :default => 0.0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.text     "observations"
    t.string   "validity"
    t.string   "delivery"
    t.string   "pay_form"
    t.integer  "quotation_id"
    t.integer  "status"
    t.integer  "type_order",       :default => 1
    t.integer  "document_type"
    t.integer  "movement_type_id"
  end

  add_index "purchase_orders", ["provider_id"], :name => "index_purchase_orders_on_provider_id"

  create_table "quotation_items", :force => true do |t|
    t.integer  "quotation_id"
    t.integer  "product_id"
    t.integer  "brand_id"
    t.float    "quantity"
    t.string   "model"
    t.string   "detail"
    t.float    "cost_unit"
    t.float    "cost_total"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "winner"
  end

  add_index "quotation_items", ["product_id"], :name => "index_quotation_items_on_product_id"
  add_index "quotation_items", ["quotation_id"], :name => "index_quotation_items_on_quotation_id"

  create_table "quotations", :force => true do |t|
    t.string   "name"
    t.integer  "provider_id"
    t.boolean  "completed",                              :default => false
    t.text     "observations"
    t.string   "quotation_provider_number"
    t.string   "validity"
    t.string   "delivery"
    t.string   "pay_form"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at",                                                :null => false
    t.integer  "status",                    :limit => 2, :default => 1,     :null => false
    t.integer  "requeriment_id"
    t.boolean  "winner"
    t.boolean  "order_generated"
  end

  add_index "quotations", ["provider_id"], :name => "index_quotations_on_provider_id"

  create_table "requeriment_items", :force => true do |t|
    t.integer  "requeriment_id"
    t.integer  "product_id"
    t.float    "quantity"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "brand_id"
    t.string   "color"
    t.string   "size"
    t.string   "model"
    t.text     "detail"
  end

  create_table "requeriments", :force => true do |t|
    t.string   "name"
    t.integer  "ware_house_id"
    t.integer  "responsible_id"
    t.boolean  "completed",                     :default => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.boolean  "type"
    t.integer  "type_requeriment"
    t.text     "observation"
    t.string   "description"
    t.string   "reference"
    t.integer  "status",           :limit => 2, :default => 1,     :null => false
    t.integer  "area_id"
    t.date     "deadline"
  end

  add_index "requeriments", ["ware_house_id"], :name => "index_requeriments_on_ware_house_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "setting_mains", :force => true do |t|
    t.string   "name"
    t.string   "ruc"
    t.string   "phone"
    t.string   "address"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sub_groups", :force => true do |t|
    t.integer  "type_sub_group"
    t.string   "name"
    t.string   "description"
    t.integer  "group_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "role_id"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "area_id",                :default => 1
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "ware_houses", :force => true do |t|
    t.string   "name"
    t.integer  "responsible_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "telephone"
    t.string   "address"
    t.string   "description"
    t.string   "cost_center"
    t.integer  "area_id"
    t.boolean  "initial",        :default => true
    t.boolean  "close",          :default => false
  end

end
