Logistic::Application.routes.draw do

  resources :setting_mains, except: :index


  resources :brands


  resources :areas

  resources :purchase_orders do
    member do
      put :canceled
    end
    collection do
      get :quotation_list
    end
  end

  get "site/index"

  resources :quotations do
    resource :purchase_orders
    member do
      get :fill_costs
      put :save_fill_costs
      get :toggle
      get :status_change
    end
    collection do
      get :compare
      get :pending_requeriment
    end
  end

  resources :providers

  resources :movement_items, only: [:update, :index]

  resources :movements, only: [:index, :show, :destroy] do
    member do
      get :print
    end
    collection do
      get :new_get_out_purchase_order
      get :new_purchase
      get :purchase_orders
      get :pending_incoming_purchases
      post :create_get_out_purchase_order
      post :create_purchase
      get :new_incoming
      post :create_incoming
      # get :new_get_out
      post :create_get_out
      get :pending_input_notes
    end
  end

  resources :requeriments do
    resources :quotations
    member do
      get :toggle
      get :status_change
    end
  end

  resources :serv_requeriments do
    resources :quotations
    member do
      get :toggle
      get :status_change
    end
  end

  resources :products
  resources :groups
  resources :sub_groups
  resources :categories
  resources :brands
  resources :input_notes

  resources :ware_houses do
    get 'new_get_out' => 'movements#new_get_out'
    get 'initial' => 'movements#initial'
    get 'physical' => 'product_ware_houses#index'
    collection do
      get :own
      get :kardex
    end
  end

  resources :product_ware_houses, only: [:index, :update] do
    collection do
      put :update_multiple
    end
  end

  devise_for :users

  resources :users

  root :to => 'site#index'

  get 'dynamic_groups_by_type' => 'javascripts#dynamic_groups_by_type'
  get 'product_by_ware_house' => 'javascripts#product_by_ware_house'
  get 'products_by_ware_house' => 'javascripts#products_by_ware_house'
  get 'dynamic_sub_groups' => 'javascripts#dynamic_sub_groups'
  get 'dynamic_categories' => 'javascripts#dynamic_categories'
  get 'dynamic_products' => 'javascripts#dynamic_products'
  get 'dynamic_brands_by_group' => 'javascripts#dynamic_brands_by_group'
  get 'dynamic_brands_by_sub_group' => 'javascripts#dynamic_brands_by_sub_group'

  get 'load_other_products_from_category' => 'javascripts#load_other_products_from_category'
  get 'load_other_categories_from_sub_group' => 'javascripts#load_other_categories_from_sub_group'
  get 'load_other_sub_groups_from_group' => 'javascripts#load_other_sub_groups_from_group'
  get 'load_other_brands_from_sub_group' => 'javascripts#load_other_brands_from_sub_group'

  get 'get_product' => 'javascripts#get_product'

end
