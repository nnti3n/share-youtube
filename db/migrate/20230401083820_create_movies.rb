class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :description
      t.string :youtube_id, null: false
      t.string :image

      t.timestamps
    end
  end
end
