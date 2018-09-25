class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes, id: :uuid do |t|
      t.references :proposal, foreign_key: true, type: :uuid
      t.string :user_id     # provider:user id ad provider

      t.boolean :tombstone  # deleted votes are stored
      t.text :headers       # prevent spamming by recording IPs etc
      t.string :user_agent
      t.string :client_ip

      t.timestamps
    end
  end
end
