class UnreadMigration < ActiveRecord::Migration
  def self.up
    create_table ReadMark, force: true, id: :uuid, default: 'gen_random_uuid()'  do |t|
      t.uuid :reader_id
      t.string :reader_type
      t.uuid :readable_id
      t.string :readable_type
      t.datetime :timestamp
    end

    add_foreign_key ReadMark, :messages, column: :readable_id
    add_foreign_key ReadMark, :users, column: :reader_id

    add_index ReadMark, [:reader_id, :reader_type, :readable_type, :readable_id], name: 'read_marks_reader_readable_index', unique: true
  end

  def self.down
    drop_table ReadMark
  end
end
