class CreateBarbers < ActiveRecord::Migration[5.2]
  def change

	create_table :barbers do |t|
  		t.text :name

  		t.timestamps
  	end

	Barber.create :name => 'Jesie Pink'
	Barber.create :name => 'Bob Smith'
	Barber.create :name => 'Gus Kaufman' 
  end
end
