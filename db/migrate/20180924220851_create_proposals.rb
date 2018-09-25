class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals, id: :uuid do |t|
      t.string :name
      t.string :link
      t.string :user_id  # who created this proposal
      t.text :bio
      t.integer :votes, :default => 0
      t.decimal :percent  # just a hack to make it easy to show percent

      t.timestamps
    end
  end
end
