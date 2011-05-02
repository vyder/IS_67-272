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

ActiveRecord::Schema.define(:version => 20110501012329) do

  create_table "gifts", :force => true do |t|
    t.integer  "invitation_id"
    t.string   "description"
    t.date     "note_sent_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guests", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "host_id"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hosts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "party_id"
    t.integer  "guest_id"
    t.string   "invite_code"
    t.integer  "expected_attendees"
    t.integer  "actual_attendees"
    t.boolean  "has_rsvpd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "host_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.integer  "host_id"
    t.integer  "party_type_id"
    t.date     "party_date"
    t.integer  "location_id"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "description"
    t.date     "rsvp_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "party_types", :force => true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
