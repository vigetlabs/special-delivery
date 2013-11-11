class CreateSpecialDeliveryDeliveries < ActiveRecord::Migration
  def change
    create_table :special_delivery_deliveries do |t|
      t.string :callback_class_name
      t.integer :deliverable_id
      t.string :deliverable_type
      t.string :message_id

      t.timestamps
    end
  end
end
