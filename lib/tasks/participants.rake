require 'FasterCSV' 

namespace :participants do

  desc 'Exports the full participant list to CSV. Does not update export date for participant'
  task :full_export => :environment do
    build_csv(Participant.all, Time.now, "full")
  end
  
  desc 'Exports the participants who have signed up since the last export. Touches each record exported to set the export date'
  task :new_participants => :environment do
    tstamp = Time.now
    new_participants = Participant.find(:all, :conditions => "exported_at is null")
    new_participants.each{|p| p.exported_at = tstamp; p.save}
    build_csv(new_participants, tstamp, "new")
  end

  def build_csv(participants, tstamp, prefix)
    fname = "#{RAILS_ROOT}/exports/participants_#{prefix}_#{tstamp.strftime("%Y%m%d-%H%M%S")}.csv"
    FasterCSV.open(fname, "w") do |csv|
      csv << ["name", "address", "apt_or_unit", "city", "state", "zip", "home_phone", "work_phone", "mobile_phone", "email", "preferred_contact_method", "signup_date", "exported_date"]
      participants.each do |p|
        csv << [p.name, p.address, p.apt_or_unit, p.city, p.state, p.zip, p.home_phone, p.work_phone, p.work_phone, p.email, p.contact_preference, p.created_at, p.exported_at]
      end
    end
    puts "Export Complete: #{participants.count} exported to #{fname}"
  end

end
